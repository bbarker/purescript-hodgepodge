#!/usr/bin/env bash
PS_VERSION=0.13.5
RELEASE=1 # a version to bump within PS versions

docker build --build-arg PS_VERSION="${PS_VERSION}" \
  -t purescript-hodgepodge:"${PS_VERSION}_r${RELEASE}" -f Dockerfile .
