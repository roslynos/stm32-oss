#!/bin/bash

# Abort script if any command returns error
set -e

sudo chmod 666 /dev/sdb
bitbake bmap-tools-native -caddto_recipe_sysroot
# ls /dev/sdb? | xargs -n1 udisksctl unmount -b
oe-run-native \
    bmap-tools-native bmaptool copy \
    ./build/tmp/deploy/images/stm32mp157f-dk2/core-image-minimal-stm32mp157f-dk2.wic.gz \
    /dev/sdb

#ls /dev/sdb? | xargs -n1 udisksctl unmount -b
udisksctl power-off -b /dev/sdb