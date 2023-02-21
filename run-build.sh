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
  git clone git://git.yoctoproject.org/poky poky -b kirkstone
  git clone git://git.openembedded.org/meta-openembedded poky/meta-openembedded -b kirkstone
  git clone http://github.com/roslynos/meta-stm32mp15x.git meta-stm32mp15x -b kirkstone
  
  _source

  bitbake-layers add-layer ../poky/meta-openembedded/meta-oe/
  bitbake-layers add-layer ../meta-roslynos-distro/
  bitbake-layers add-layer ../meta-stm32mp15x/
  bitbake-layers add-layer ../meta-stm32-oss/
}

bake() {
  _source
  bitbake stm32-image-minimal
}

flash() {
  _source
  bitbake bmap-tools-native -caddto_recipe_sysroot
  sudo chmod 666 /dev/sdb

  oe-run-native \
      bmap-tools-native bmaptool copy \
      ./tmp/deploy/images/stm32mp157f-dk2/stm32-image-minimal-stm32mp157f-dk2.wic.gz \
      /dev/sdb

  udisksctl power-off -b /dev/sdb
}

update() {
  git fetch --all
}

packages() {
  _source

  bitbake -g stm32-image-minimal
  cat pn-buildlist | grep -v native | sort
}

clean() {
  _source
  bitbake stm32-image-minimal-c clean
}

_source() {
  source ./poky/oe-init-build-env $BUILD_DIR
}

if [[ $# -eq 0 ]] ; then
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
  flash)
    shift
    flash "$@"
    ;;
  clean)
    shift
    clean "$@"
    ;;
  update)
    shift
    update "$@"
    ;;
  packages)
    shift
    packages "$@"
    ;;
esac