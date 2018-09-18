# PROGRAM_NAME is the name of the GIT repository.
# It should match <artifactId> in pom.xml
PROGRAM_NAME := $(shell basename `git rev-parse --show-toplevel`)

# Information from git

GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
GIT_REPOSITORY_NAME := $(shell basename `git rev-parse --show-toplevel`)
GIT_SHA := $(shell git log --pretty=format:'%H' -n 1)
GIT_TAG ?= $(shell git describe --always --tags | awk -F "-" '{print $$1}')
GIT_TAG_END ?= HEAD
GIT_VERSION := $(shell git describe --always --tags --long --dirty | sed -e 's/\-0//' -e 's/\-g.......//')
GIT_VERSION_LONG := $(shell git describe --always --tags --long --dirty)

# Docker

DOCKER_IMAGE := $(GIT_REPOSITORY_NAME):$(GIT_VERSION)

# -----------------------------------------------------------------------------
# The first "make" target runs as default.
# -----------------------------------------------------------------------------

.PHONY: default
default: help

# -----------------------------------------------------------------------------
# Local development
# -----------------------------------------------------------------------------

.PHONY: package
package:
	mvn package \
	  -Dproject.version=$(GIT_VERSION) \
	  -Dgit.branch=$(GIT_BRANCH) \
	  -Dgit.repository.name=$(GIT_REPOSITORY_NAME) \
	  -Dgit.sha=$(GIT_SHA) \
	  -Dgit.version.long=$(GIT_VERSION_LONG)

.PHONY: run
run:
	mvn exec:java -Dproject.version=$(GIT_VERSION)

# -----------------------------------------------------------------------------
# Docker-based builds
# -----------------------------------------------------------------------------

.PHONY: docker-package
docker-package:
	# Make docker image.

	docker rmi --force $(DOCKER_IMAGE)
	docker build \
		--build-arg BUILD_VERSION=$(GIT_VERSION) \
		--build-arg GIT_REPOSITORY_NAME=$(GIT_REPOSITORY_NAME) \
		--tag $(DOCKER_IMAGE) \
		.

	# Run docker image which creates a docker container.
	# Then, copy the maven output from the container to the local workstation.
	# Finally, remove the docker container.

	PID=$$(docker create $(DOCKER_IMAGE) /bin/bash); \
	docker cp $$PID:/$(GIT_REPOSITORY_NAME)/target .; \
	docker rm -v $$PID

# -----------------------------------------------------------------------------
# Git helpers
# -----------------------------------------------------------------------------

.PHONY: git-iterations
git-iterations:
	git log $(GIT_TAG)..$(GIT_TAG_END) --reverse --oneline | nl

.PHONY: git-iterations-all
git-iterations-all:
	git log --reverse --oneline --decorate=short | nl

.PHONY: git-sha-last
git-sha-last:
	git log --pretty=format:'%H' -n 1

.PHONY: git-tag-last
git-tag-last:
	git describe --always --tags | awk -F "-" '{print $$1}'

.PHONY: git-tag-list
git-tag-list:
	git log --oneline --decorate=short | grep 'tag:' | awk -F'tag: ' '{sub(/[ |,|\)].*/,"",$$2); print $$2}'

# -----------------------------------------------------------------------------
# Utility targets
# -----------------------------------------------------------------------------

# Just a check to see if all of the prerequisites are installed and working.
.PHONY: precheck
precheck:
	git --version
	mvn --version
	docker --version

.PHONY: filename
filename:
	@echo '$(PROGRAM_NAME)-$(GIT_VERSION).jar'

.PHONY: clean
clean:
	-mvn clean -Dproject.version=$(GIT_VERSION)
	-docker rmi --force $(DOCKER_IMAGE)

.PHONY: help
help:
	@echo 'make commands for $(PROGRAM_NAME)-$(GIT_VERSION).jar'
	@echo '  "make package"             Build locally'
	@echo '  "make docker-package"      Build in a docker container'
	@echo '  "make run"                 Run the java program'
	@echo '  "make clean"               Delete generated artifacts'
	@echo '  "make git-iterations"      Show iterations since last tag'
	@echo '  "make git-iterations-all"  Show iterations since beginning'
	@echo '  "make git-sha-last"        Show SHA of last commit'
	@echo '  "make git-tag-last"        Show last tag defined'
	@echo '  "make git-tag-list"        Show list of tags'
	@echo ''
	@echo 'Git information:'
	@echo '   Branch: $(GIT_BRANCH)'
	@echo '      SHA: $(GIT_SHA)'	
	@echo '  Version: $(GIT_VERSION_LONG)'
	@echo ''
	@echo "List of make targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
