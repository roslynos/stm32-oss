FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://dot.profile \
    file://dot.bashrc \
    file://defconfig \
"

do_install:append() {
    install -m 0644 ${WORKDIR}/dot.profile ${D}${sysconfdir}/skel/.profile
    install -m 0644 ${WORKDIR}/dot.bashrc ${D}${sysconfdir}/skel/.bashrc
    install -m 0644 ${WORKDIR}/defconfig ${B}/.config
}