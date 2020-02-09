#!/usr/bin/env bash

#
# Use like: ./push.sh <version>_r<release>
# This will also updated the 'latest' tag.
#

NUMARGS=1

if [ $# -lt $NUMARGS ]; then
  echo 1>&2 "$0: not enough arguments"
  exit 2
elif [ $# -gt $NUMARGS ]; then
  echo 1>&2 "$0: too many arguments"
  exit 2
fi

VERSION=$1

# Make sure to `docker login` if needed

docker tag purescript-hodgepodge:"${VERSION}" bbarker/purescript-hodgepodge:"${VERSION}"
docker tag purescript-hodgepodge:"${VERSION}" bbarker/purescript-hodgepodge:latest
docker push bbarker/purescript-hodgepodge:"${VERSION}"
docker push bbarker/purescript-hodgepodge:latest
