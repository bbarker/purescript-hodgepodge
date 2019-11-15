#!/usr/bin/env bash

# A convenience script for running local builds
# Need to edit the tag below (IMG_VER):


DHUB_PREFIX="" IMG_VER="0.13.5" source "${BASH_SOURCE%/*}/psc.sh" "$@"
