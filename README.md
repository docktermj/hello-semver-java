# hello-semver-java

Explore Semantic Versioning in a Java project.

## Demonstration

### Preparation

#### Set Environment variables

These variables may be modified, but do not need to be modified.
The variables are used throughout the installation procedure.

```console
export GIT_ACCOUNT=docktermj
export GIT_REPOSITORY=hello-semver-java
```

Synthesize environment variables.

```console
export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
export GIT_REPOSITORY_URL="git@github.com:${GIT_ACCOUNT}/${GIT_REPOSITORY}.git"
```

#### Clone repository

Get repository.

```console
mkdir --parents ${GIT_ACCOUNT_DIR}
cd  ${GIT_ACCOUNT_DIR}
git clone ${GIT_REPOSITORY_URL}
```

#### Verify development environment

```console
cd ${GIT_REPOSITORY_DIR}
make precheck
```

### Demo 1 - Local build and run

This is the pattern of usage during development.
The artifact is built and tested on a local workstation.

#### Build local

```console
cd ${GIT_REPOSITORY_DIR}
make package
```

#### Run local

```console
cd ${GIT_REPOSITORY_DIR}
make run
```

#### Cleanup local

```console
cd ${GIT_REPOSITORY_DIR}
make clean
```

### Demo 2 - Docker-based build and run

This is the pattern of usage during the final development stage and in continuous integration (CI).
The artifact is built and tested on a clean docker image.

#### Build via docker

```console
cd ${GIT_REPOSITORY_DIR}
make docker-package
```

#### Run via docker

```console
cd ${GIT_REPOSITORY_DIR}
make run
```

#### Cleanup via docker

```console
cd ${GIT_REPOSITORY_DIR}
make clean
```

### Demo 3 - Building specific version

### Demo 4 - Building a specific git SHA

### Demo 5 - Comparing code across versions
