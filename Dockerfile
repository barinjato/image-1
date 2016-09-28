## Base
FROM ubuntu:xenial

## Maintainer
MAINTAINER Barinjato Ramanandray "barinjato@gmail.com"

## Tool versions
ARG NODE_VERSION=v4.2.6

## Utilities
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
     ca-certificates \
     sudo \
     curl \
     git \
     shellcheck \
  && rm -rf /var/lib/apt/lists/*

## NodeJS
RUN cd /opt \
    &&  curl --silent --location --output node.tar.gz "http://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz" \
    &&  tar -zxf node.tar.gz \
    &&  rm node.tar.gz
ENV NODE_HOME /opt/node-${NODE_VERSION}-linux-x64
ENV PATH $PATH:$NODE_HOME/bin

## CloudFoundry CLI
ENV CF_CLI_HOME /opt/cf_cli
RUN mkdir ${CF_CLI_HOME} \
    && curl --silent --location "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx -C ${CF_CLI_HOME}
ENV PATH ${PATH}:${CF_CLI_HOME}

## Create user: user1
RUN useradd user1 --shell /bin/bash --create-home \
  && usermod -a -G sudo user1 \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'user1:secret' | chpasswd
USER user1
ENV USER_HOME /home/user1
COPY bash.rc ${USER_HOME}/.bashrc
WORKDIR ${USER_HOME}

## Change the permission to npm's default directory to avoid EACCES error when installing a package globally
RUN sudo chown -R user1 $(npm config get prefix)/*
# RUN sudo chown -R user1 $(npm config get prefix)/{lib/node_modules,bin,share}

## CloudFoundry CLI setup
ENV CF_HOME ${USER_HOME}

## Additional tools
RUN npm install -g grunt-cli
RUN npm install -g bunyan
RUN npm install -g bower

## Expose some ports
EXPOSE 3550
