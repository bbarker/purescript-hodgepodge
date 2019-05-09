#!/usr/bin/env bash
PS_VERSION=0.12.5
docker build --build-arg PS_VERSION="${PS_VERSION}" \
  -t purescript-hodgepodge:"${PS_VERSION}" -f Dockerfile .
