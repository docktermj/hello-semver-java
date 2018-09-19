# hello-semver-java

Explore [Semantic Versioning](https://semver.org/) in a Java project.

## Background

### Why Semantic Versioning

[Semantic Versioning](https://semver.org/) (a.k.a SemVer)
helps customers of your public API avoid breakage.

Semantic Versioning's MAJOR.MINOR.PATCH scheme has the following semantics:

> 1. MAJOR version when you make incompatible API changes,
> 2. MINOR version when you add functionality in a backwards-compatible manner, and
> 3. PATCH version when you make backwards-compatible bug fixes.
>
> -- <cite>Semantic Versioning 2.0's [Summary](https://semver.org/#summary)</cite>

It allows tool chains to gracefully use new functionality
and prevent breakage upon incompatible API changes.

If your software does not support a public API,
then Semantic Versioning may not be a good fit.

### Maven dependency management used by the customer

In this example, a customer is using version 1.x.x and avoiding 2.0.0 and above
during their build process.
By doing this, the customer prevents surprise breakage
due to a backwards incompatible API change.
Naturally, a customer would migrate to 2.0.0 and above,
but only after testing their usage of the new API against their code.

In a Maven `pom.xml` file, a customer would
specify the use of only versions 1.x.x in the `<version>` XML stanza like this:

```xml
    <project xmlns="http://maven.apache.org/POM/4.0.0"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                          https://maven.apache.org/xsd/maven-4.0.0.xsd">
      ...
      <dependencies>
        <dependency>
          <groupId>com.dockter</groupId>
          <artifactId>hello-semver-java</artifactId>
          <version>[1.0,2.0)</version>
          <type>jar</type>
        </dependency>
        ...
      </dependencies>
      ...
    </project>
```

If a customer uses functionality introduced in a MINOR release, the version can be more specific.
For instance, if the customer code relies on an API introduced in version `1.3.0`, the `pom.xml` would specify this:

```xml
          <version>[1.3,2.0)</version>
```

References:

1. [Dependency Version Requirement Specification](https://maven.apache.org/pom.html#Dependency_Version_Requirement_Specification)
1. [Maven Version Range Specification](https://maven.apache.org/enforcer/enforcer-rules/versionRanges.html)

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

#### make help

Running `make` without parameters will show the help information.

```console
$ cd ${GIT_REPOSITORY_DIR}
$ make
make commands for hello-semver-java-0.0.9.jar
  "make package"             Build locally
  "make docker-package"      Build in a docker container
  "make run"                 Run the java program
  "make clean"               Delete generated artifacts
  "make git-iterations"      Show iterations since last tag
  "make git-iterations-all"  Show iterations since beginning
  "make git-sha-last"        Show SHA of last commit
  "make git-tag-last"        Show last tag defined
  "make git-tag-list"        Show list of tags

Git information:
   Branch: master
      SHA: 0ec10c6aa17faedb833f33b5d2e85681e73a1ae1
  Version: 0.0.9-0-g0ec10c6

List of make targets:
clean default docker-package filename git-iterations git-iterations-all git-sha-last git-tag-last git-tag-list package precheck run
```

The first line of the output:

```console
make commands for hello-semver-java-0.0.9.jar
```

shows the name of the file that will be build by running `make package` or `make docker-package`.

The `Git information:` shows information from various `git` commands to show the state of the local repository.

The `List of make targets:` shows all of the targets defined in the `Makefile`.
It serves as a reminder of what `make` targets exist.

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

### Demo 3 - Dirty builds

The resulting JAR filename may have 3 different formats.
Examples:

1. hello-semver-java-0.0.9.jar
1. hello-semver-java-0.0.9-1.jar
1. hello-semver-java-0.0.9-1-dirty.jar

`hello-semver-java-0.0.9.jar`
is an example of a build for a specific release tag.

`hello-semver-java-0.0.9-1.jar`
is an example of a build that is 2 "iterations" after a specific release tag.

`hello-semver-java-0.0.9-1-dirty.jar`
is an example of code that has been locally modified 2 iterations after a specific release tag.

To demonstrate:

```console
cd ${GIT_REPOSITORY_DIR}
git checkout 0.0.9
make filename

git checkout c65ecdc
make filename

echo "" >> README.md
make filename
git checkout README.md

git checkout master
make filename
```

### Demo 4 - Build specific version

List versions.

```console
cd ${GIT_REPOSITORY_DIR}
make git-tag-list
```

Choose version. Example:

```console
cd ${GIT_REPOSITORY_DIR}
git checkout 0.0.9
```

Run commands in [Demo package-run-cleanup](#demo-package-run-cleanup).

### Demo 5 - Build specific version and iteration

This demonstration builds `hello-semver-java-0.0.4-2.jar,
a file with a version ('0.0.4') and an iteration ('2').

List versions starting at tag `0.0.4` using the `GIT_TAG` parameter.

```console
$ cd ${GIT_REPOSITORY_DIR}
$ make git-iterations GIT_TAG=0.0.9

git log 0.0.9..HEAD --reverse --oneline | nl
     1	c65ecdc issue-1 Modify examples
     2	179bf58 Merge pull request #15 from docktermj/issue-1.dockter.1
```

Look for iteration #2,
"`2	179bf58 Merge pull request #15 from docktermj/issue-1.dockter.1`"

Use the hashed SHA from iteration 2 in the list to perform the `git checkout`.

```console
cd ${GIT_REPOSITORY_DIR}
git checkout 179bf58
```

Run commands in [Demo package-run-cleanup](#demo-package-run-cleanup).

### Demo 6 - Build specific git SHA

In each JAR file created, there is a `build-info.properties` file.
Example contents:

```properties
# Build information

build.file=hello-semver-java-0.0.9-1.jar
build.timestamp=2018-09-18 19:59

# Maven information

maven.version=0.0.9-1
maven.groupId=com.dockter
maven.artifactId=hello-semver-java

# Git information

git.branch=HEAD
git.repository.name=hello-semver-java
git.sha=c65ecdc2b66d9ac079b6592f893a6b6a00e6402c
git.version.long=0.0.9-1-gc65ecdc
```

To rebuild the JAR file
or simply inspect the code used to produce the JAR file,
use the `git.sha` value in the `build-info.properties` file
when doing a `git checkout`.
Example:

```console
cd ${GIT_REPOSITORY_DIR}
git checkout c65ecdc2b66d9ac079b6592f893a6b6a00e6402c
```

Run commands in [Demo package-run-cleanup](#demo-package-run-cleanup).

### Demo 7 - Compare code across versions

Based on Git's documentation for [git diff](https://git-scm.com/docs/git-diff).

Get the hashed SHA for two versions.
Example

```console
$ cd ${GIT_REPOSITORY_DIR}
$ make git-iterations

git log 0.0.5..HEAD --reverse --oneline | nl
     1 18a9de7 issue-1 Add instructions for specific version
     2 1b62f4a issue-1 Working on tag/iteration builds
     3 961cc23 issue-1 Documenting building to git SHA
```

Then pick 2 hashed SHAs for the `git diff`.
Example:

```console
git diff 18a9de7 1b62f4a
```

### Demo package-run-cleanup

This is re-usable code from demonstration above.

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
