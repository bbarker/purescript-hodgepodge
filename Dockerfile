FROM node:12

MAINTAINER Brandon Elam Barker
# Based on Alexej Bondarenko's Dockerfile at:
# https://raw.githubusercontent.com/ersocon/docker-purescript/master/Dockerfile

ARG PS_VERSION
ENV PURESCRIPT_DOWNLOAD_SHA1 58b14014ba08ef6550fa61700797688d27a9a2f3
ENV PSC_PACKAGE_DOWNLOAD_SHA1 09e033708f412e25ff049e5a9de42438b4696a33
ENV SPAGO_DOWNLOAD_SHA1 bd2ceddf50e7e7f22581c0cbcaebc7ff6c797924

RUN apt-get update && apt-get install -y libsecret-1-dev \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g bower parcel-bundler pulp@12.4.2 yarn@1.15.2

RUN mkdir -p /opt/bin && cd /opt \
    && wget https://github.com/purescript/purescript/releases/download/v${PS_VERSION}/linux64.tar.gz \
    && echo "$PURESCRIPT_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz \
    && wget https://github.com/purescript/psc-package/releases/download/v0.5.1/linux64.tar.gz \
    && echo "$PSC_PACKAGE_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz \
    && wget https://github.com/spacchetti/spago/releases/download/0.12.1.0/linux.tar.gz \
    && echo "$SPAGO_DOWNLOAD_SHA1 linux.tar.gz" | sha1sum -c - \
    && tar -xvf linux.tar.gz -C bin/ \
    && rm /opt/linux.tar.gz

ENV PATH /opt/bin:/opt/purescript:/opt/psc-package:$PATH

RUN echo "#!/usr/bin/env bash\n\$@\n" > /opt/entrypoint && \
  chmod a+x /opt/entrypoint

ENTRYPOINT ["/opt/entrypoint"]
