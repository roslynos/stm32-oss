SUMMARY = "Set permission on can devices"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302" 

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "file://can.rules"    

do_install[nostamp] = "1"
do_unpack[nostamp] = "1"    

do_install () {
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/can.rules ${D}${sysconfdir}/udev/rules.d/can.rules
}    

FILES_${PN} += "${sysconfdir}/udev/rules.d/can.rules"    

PACKAGES = "${PN}"
PROVIDES = "udev-rules-can"