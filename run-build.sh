#!/bin/bash

# Abort script if any command returns error
set -e

BUILD_DIR="build"

install() {
    sudo apt-get update
    sudo apt-get install -y language-pack-en
    sudo apt-get install -y gawk wget git diffstat unzip texinfo gcc build-essential \
        chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils \
        iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
        xterm python3-subunit mesa-common-dev zstd liblz4-tool file
}

init() {
  _source
  bitbake-layers add-layer ../poky/meta-openembedded/meta-oe/
}

bake() {
  _source
  bitbake core-image-minimal
}

_source() {
  source ./poky/oe-init-build-env $BUILD_DIR
}

f [[ $# -eq 0 ]] ; then
  bake
fi

case $1 in
  install)
    shift
    install "$@"
    ;;
  init)
    shift
    init "$@"
    ;;
  bake)
    shift
    bake "$@"
    ;;
esac