#!/usr/bin/env bash

#
# If you found this in a repository other than
# purescript-hodgepodge, know that it was likely copied or modified
# from the script of the same name located at
# https://github.com/bbarker/purescript-hodgepodge
#
# You can find more information there about this script.
#


# This script has the following differences from psc.sh
# 1. Does not perform any volume mounts so as to be completely
#    isolated, and as a side effect, requires fewer docker privileges.
# 2. Names the container so that it can be re-used, and re-uses the
#    existing container if it exists and is not already running.

: "${IMG_NAME:=purescript-hodgepodge}"
: "${IMG_VER:=latest}"
# Set this to the empty string to use locally built image:
if ! [[ -v "DHUB_PREFIX" ]]; then
  : "${DHUB_PREFIX:=bbarker/}"
fi

CONT_NAME=purescript-hodgepodge-isolated

USE_EXISTING=false

if docker ps -a | grep -q "${CONT_NAME}" ; then
  FOUND_IMG=$(docker inspect --format='{{.Config.Image}}' "${CONT_NAME}")
  if [ "$FOUND_IMG" = "${IMG_NAME}:${IMG_VER}" ]; then
    USE_EXISTING=true
  fi
fi

if [ "USE_EXISTING" = true ]; then
    docker exec -it "${CONT_NAME}" ....... oh yeah the container is stopped ......
else
  # If really an empty string, then we interpret as using a local image
  # and do not pull:
  if ! [ -z "$DHUB_PREFIX" ]; then
    docker pull "${DHUB_PREFIX}${IMG_NAME}:${IMG_VER}"
  fi

  docker run -ti \
         --workdir /wd \
         "${DHUB_PREFIX}${IMG_NAME}:${IMG_VER}" "$@"
fi

# Add this before the last line (image name) for debugging:
#        --entrypoint "/bin/bash" \
