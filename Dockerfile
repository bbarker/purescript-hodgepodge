FROM node:14

# Based on Alexej Bondarenko's Dockerfile at:
# https://raw.githubusercontent.com/ersocon/docker-purescript/master/Dockerfile

ARG PS_VERSION
ENV PURESCRIPT_DOWNLOAD_SHA1 766c6f2945ca92e9ea1a469fe150d964edb67875
ENV PSC_PACKAGE_DOWNLOAD_SHA1 f5909699c46cca950be139cdd902f233ff01da10
ENV SPAGO_DOWNLOAD_SHA1 5c3b6a715c69197d7ff2a4f2f7359741ab094ba2

RUN apt-get update && apt-get install -y libsecret-1-dev \
  && rm -rf /var/lib/apt/lists/*

RUN npm install --unsafe-perm=true --allow-root -g \
  bower parcel-bundler pulp@15.0.0

RUN mkdir -p /opt/bin && cd /opt \
    && wget https://github.com/purescript/purescript/releases/download/v${PS_VERSION}/linux64.tar.gz \
    && echo "$PURESCRIPT_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz \
    && wget https://github.com/purescript/psc-package/releases/download/v0.6.2/linux64.tar.gz \
    && echo "$PSC_PACKAGE_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz \
    && wget https://github.com/spacchetti/spago/releases/download/0.16.0/linux.tar.gz \
    && echo "$SPAGO_DOWNLOAD_SHA1 linux.tar.gz" | sha1sum -c - \
    && tar -xvf linux.tar.gz -C bin/ \
    && rm /opt/linux.tar.gz

ENV PATH /opt/bin:/opt/purescript:/opt/psc-package:$PATH

RUN echo "#!/usr/bin/env bash\n\$@\n" > /opt/entrypoint && \
  chmod a+x /opt/entrypoint

ENTRYPOINT ["/opt/entrypoint"]
