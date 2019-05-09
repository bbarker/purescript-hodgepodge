#!/usr/bin/env bash

#
# If you found this in a repository other than
# purescript-hodgepodge, know that it was likely copied or modified
# from the script of the same name located at
# https://github.com/bbarker/purescript-hodgepodge
#
# You can find more information there about this script.
#


# Set this to the empty string to use locally built image:
DHUB_PREFIX="bbarker/"
IMG_NAME=purescript-hodgepodge
IMG_VER="latest"

# Make these directories so docker (root) does not!
mkdir -p ~/.pulp
mkdir -p ~/.npm
mkdir -p ~/.npm-packages
mkdir -p ~/.cache
touch ~/.pulp/github-oauth-token

docker pull "${DHUB_PREFIX}${IMG_NAME}:${IMG_VER}"

docker run --rm -ti \
       --volume /etc/passwd:/etc/passwd:ro \
       --volume "$PWD":/wd \
       --volume "$HOME/.gitconfig:$HOME/.gitconfig:ro" \
       --volume "$HOME/.ssh:$HOME/.ssh:ro" \
       --volume "$HOME/.pulp:$HOME/.pulp" \
       --volume "$HOME/.cache:$HOME/.cache" \
       --volume "$HOME/.npmrc:$HOME/.npmrc" \
       --volume "$HOME/.npm:$HOME/.npm" \
       --volume "$HOME/.npm-packages:$HOME/.npm-packages" \
       --user "$UID" \
       --workdir /wd \
       -e "XDG_CONFIG_HOME=/wd/.xdg_config_home" \
       -e "XDG_DATA_HOME=/wd/.xdg_data_home" \
       "${DHUB_PREFIX}${IMG_NAME}:${IMG_VER}" "$@"

# Add this before the last line (image name) for debugging:
#        --entrypoint "/bin/bash" \
