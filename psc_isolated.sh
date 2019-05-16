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
# 2. Does not specify user; `docker cp` should suffice for extracting files
# 3. Leaves the container around for e.g. `docker cp` but deletes
#    a container of the same name if found

CONT_NAME=purescript-hodgepodge-isolated
if docker ps -a | grep -q "${CONT_NAME}" ; then
  docker rm -f "${CONT_NAME}"
fi

: "${IMG_NAME:=purescript-hodgepodge}"
: "${IMG_VER:=latest}"
# Set this to the empty string to use locally built image:
if ! [[ -v "DHUB_PREFIX" ]]; then
  : "${DHUB_PREFIX:=bbarker/}"
fi

# If really an empty string, then we interpret as using a local image
# and do not pull:
if ! [ -z "$DHUB_PREFIX" ]; then
  docker pull "${DHUB_PREFIX}${IMG_NAME}:${IMG_VER}"
fi

docker run -ti \
       --name "${CONT_NAME}" \
       --workdir /wd \
       "${DHUB_PREFIX}${IMG_NAME}:${IMG_VER}" "$@"

# Add this before the last line (image name) for debugging:
#        --entrypoint "/bin/bash" \
