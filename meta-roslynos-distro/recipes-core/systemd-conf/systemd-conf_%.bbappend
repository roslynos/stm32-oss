FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://eth.network \
    file://ap.network \
    file://wlan.network \
    file://70-ap-interface.rules \
    file://30-ipforward.conf \
"

FILES:${PN} += " \
    ${sysconfdir}/systemd/network/eth.network \
    ${sysconfdir}/systemd/network/ap.network \
    ${sysconfdir}/systemd/network/wlan.network \
    ${sysconfdir}/udev/rules.d/70-ap-interface.rules \
    ${sysconfdir}/sysctl.d/30-ipforward.conf \
"

do_install:append() {
    
    install -d ${D}${sysconfdir}/systemd/network
    install -m 644 ${WORKDIR}/eth.network ${D}${sysconfdir}/systemd/network
    install -m 644 ${WORKDIR}/ap.network ${D}${sysconfdir}/systemd/network
    install -m 644 ${WORKDIR}/wlan.network ${D}${sysconfdir}/systemd/network
   
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 644 ${WORKDIR}/70-ap-interface.rules ${D}${sysconfdir}/udev/rules.d

    install -d ${D}${sysconfdir}/sysctl.d
    install -m 644 ${WORKDIR}/30-ipforward.conf ${D}${sysconfdir}/sysctl.d

}
