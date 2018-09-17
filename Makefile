# PROGRAM_NAME is the name of the GIT repository.
# It should match <artifactId> in pom.xml
PROGRAM_NAME := $(shell basename `git rev-parse --show-toplevel`)

# Information from git

GIT_REPOSITORY_NAME := $(shell basename `git rev-parse --show-toplevel`)
GIT_VERSION := $(shell git describe --always --tags --long --dirty | sed -e 's/\-0//' -e 's/\-g.......//')
GIT_SHA := $(shell git log --pretty=format:'%H' -n 1)

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
	  -Dgit.repository.name=$(GIT_REPOSITORY_NAME) \
	  -Dgit.sha=$(GIT_SHA)

.PHONY: run
run:
	mvn exec:java -Dproject.version=$(GIT_VERSION)

# -----------------------------------------------------------------------------
# Utility targets
# -----------------------------------------------------------------------------

.PHONY: precheck
precheck:
	git --version
	mvn --version

.PHONY: clean
clean:
	-mvn clean -Dproject.version=$(GIT_VERSION)

.PHONY: help
help:
	@echo 'make commands for $(PROGRAM_NAME)-$(GIT_VERSION).jar:'
	@echo '  "make package"                      Build locally'
	@echo '  "make run"                          Run the java program'  
	@echo "List of make targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
