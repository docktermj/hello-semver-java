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

#### Package local

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

#### Package via docker

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

### Demo 3 - Build specific version

List versions.

```console
cd ${GIT_REPOSITORY_DIR}
make git-tag-list
```

Choose version. Example:

```console
cd ${GIT_REPOSITORY_DIR}
git checkout 0.0.4
```

Run commands in [Demo package-run-cleanup](#demo-package-run-cleanup).

### Demo 4 - Build specific version and iteration

This demonstration builds `hello-semver-java-0.0.4-2.jar,
a file with a version ('0.0.4') and an iteration ('2').

List versions starting at tag `0.0.4` using the `GIT_TAG` parameter.

```console
$ cd ${GIT_REPOSITORY_DIR}
$ make git-iterations GIT_TAG=0.0.4

git log 0.0.4..HEAD --reverse --oneline | nl
     1 b53fcd5 issue-1 Added Dockerfile and examplar git commands
     2 ce5a763 Merge pull request #9 from docktermj/issue-1.dockter.1
     3 e475c06 issue-1 Upped to version to 0.0.5
     4 7da7d26 Merge pull request #10 from docktermj/issue-1.dockter.1
     5 18a9de7 issue-1 Add instructions for specific version
```

Look for iteration #2,
"`2 ce5a763 Merge pull request #9 from docktermj/issue-1.dockter.1`"

Use the hashed SHA from iteration 2 in the list to perform the `git checkout`.

```console
cd ${GIT_REPOSITORY_DIR}
git checkout ce5a763
```

Run commands in [Demo package-run-cleanup](#demo-package-run-cleanup).

### Demo 5 - Build specific git SHA

In each JAR file created, there is a `build-info.properties` file.
Example contents:

```properties
# Build information

build.file=hello-semver-java-0.0.5-2.jar
build.timestamp=2018-09-17 21:08

# Maven information

version=0.0.5-2
groupId=com.dockter
artifactId=hello-semver-java

# Git information

git.repository.name=hello-semver-java
git.sha=1b62f4a951bd6b67ea41810aa8f4e92377f5bef6
```

To rebuild the JAR file
or simply inspect the code used to produce the JAR file,
use the `git.sha` value in the `build-info.properties` file
when doing a `git checkout`.
Example:

```console
cd ${GIT_REPOSITORY_DIR}
git checkout 1b62f4a951bd6b67ea41810aa8f4e92377f5bef6
```

Run commands in [Demo package-run-cleanup](#demo-package-run-cleanup).

### Demo 6 - Compare code across versions

### Demo package-run-cleanup

#### Package

```console
cd ${GIT_REPOSITORY_DIR}
make package
```

#### Run

```console
cd ${GIT_REPOSITORY_DIR}
make run
```

#### Cleanup

```console
cd ${GIT_REPOSITORY_DIR}
make clean
```

#### Checkout master branch

```console
cd ${GIT_REPOSITORY_DIR}
git checkout master
```
