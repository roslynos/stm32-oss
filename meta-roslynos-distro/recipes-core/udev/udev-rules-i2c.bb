SUMMARY = "Set permission on i2c devices"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302" 

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "file://i2c.rules"    

do_install[nostamp] = "1"
do_unpack[nostamp] = "1"    

do_install () {
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/i2c.rules ${D}${sysconfdir}/udev/rules.d/i2c.rules
}    

FILES_${PN} += "${sysconfdir}/udev/rules.d/i2c.rules"    

PACKAGES = "${PN}"
PROVIDES = "udev-rules-i2c"