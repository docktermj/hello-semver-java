FROM maven:3-jdk-8

ARG REFRESHED_AT=2018-09-17
ARG GIT_REPOSITORY_NAME=unknown

# Install prerequisites.

RUN apt-get update \
 && apt-get -y install \
      make \
 && apt-get clean

# Copy the repository from the local host.

COPY . /${GIT_REPOSITORY_NAME}

# Run the "make" command to create the artifacts.

WORKDIR /${GIT_REPOSITORY_NAME}
RUN make package

CMD /bin/bash
