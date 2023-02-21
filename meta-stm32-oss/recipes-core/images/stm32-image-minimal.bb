SUMMARY = "A minimal console-only runtime image for STM32MP1 devices"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# Core boot image configuration
inherit core-image

# Setup default user and passwords
inherit roslynos-users

# Specifies the list of locales to install into the image
LINGUAS_EN_GB = "en-gb en-gb.iso-8859-1"
LINGUAS_EN_US = "en-us en-us.iso-8859-1"
IMAGE_LINGUAS = "${LINGUAS_EN_GB} ${LINGUAS_EN_US}"

# Do a quiet boot with limited console messages
# APPEND += "rootfstype=ext4 quiet"
# AUTO_SYSLINUXMENU = "0"
# SYSLINUX_PROMPT ?= "0"
# SYSLINUX_TIMEOUT ?= "0"

# Adds 4GB extra free space to the root filesystem
IMAGE_ROOTFS_EXTRA_SPACE = "4194304"

# Additional application configuration
CORE_IMAGE_EXTRA_INSTALL += "\
    watchdog \
    udev-rules-gpio \
    udev-rules-i2c \
    udev-rules-spi \
    packagegroup-roslynos-base \
"

PACKAGE_EXCLUDE += "perl"

# perform some changes to the rootfs
rootfs_postprocess() {

    # image timastamp
    date "+%m%d%H%M%Y" > ${IMAGE_ROOTFS}/etc/timestamp

    # board type
    echo 'export PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin' > ${IMAGE_ROOTFS}/etc/profile.d/board.sh
    echo 'export BOARD='${MACHINE} >> ${IMAGE_ROOTFS}/etc/profile.d/board.sh
}

ROOTFS_POSTPROCESS_COMMAND += "rootfs_postprocess;"