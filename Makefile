# PROGRAM_NAME is the name of the GIT repository.
# It should match <artifactId> in pom.xml
PROGRAM_NAME := $(shell basename `git rev-parse --show-toplevel`)

GIT_VERSION := $(shell git describe --always --tags --abbrev=0 --dirty)

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
	mvn package -Dproject.version=$(GIT_VERSION)

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
	@echo 'Build $(PROGRAM_NAME) version $(GIT_VERSION)'
	@echo 'Example make commands:'
	@echo '  "make package"                      Build locally'
	@echo '  "make run"                          Run the java program'  
	@echo "List of make targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
