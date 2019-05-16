#!/usr/bin/env bash

IMG_NAME=purescript
IMG_VER=0.12.4

USE_EXISTING=false

if docker ps -a | grep -q confident_ellis; then
  echo found
  FOUND_IMG=$(docker inspect --format='{{.Config.Image}}' confident_ellis)
  echo $FOUND_IMG
  if [ "$FOUND_IMG" = "${IMG_NAME}:${IMG_VER}" ]; then
    USE_EXISTING=true
  fi
else
  echo not found
fi

echo $USE_EXISTING
