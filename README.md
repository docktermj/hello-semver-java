# hello-semver-java

Explore Semantic Versioning in a Java project.

## Demonstration

### Set up a development environment

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

### Verify development environment

```console
cd ${GIT_REPOSITORY_DIR}
make precheck
```

### Build

```console
cd ${GIT_REPOSITORY_DIR}
make package
```

### Run

```console
cd ${GIT_REPOSITORY_DIR}
make run
```

### Cleanup

```console
cd ${GIT_REPOSITORY_DIR}
make clean
```
