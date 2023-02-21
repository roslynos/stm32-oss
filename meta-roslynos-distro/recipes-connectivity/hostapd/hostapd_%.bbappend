FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

inherit systemd

SRC_URI += " \
   file://hostapd-ap0.conf \
   file://hostapd@.service \
"

FILES:${PN} += " \
    ${sysconfdir} \
    ${systemd_system_unitdir} \
"

#NATIVE_SYSTEMD_SUPPORT = "1"
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN} = "hostapd@ap0.service"
SYSTEMD_AUTO_ENABLE:${PN} = "disable"

REQUIRED_DISTRO_FEATURES = "systemd"

do_install:append () {
    
    install -d ${D}${sysconfdir}
    install -D -m 600 ${WORKDIR}/hostapd-ap0.conf ${D}${sysconfdir}

    install -d ${D}${systemd_system_unitdir}
    install -D -m 0644 ${WORKDIR}/hostapd@.service ${D}${systemd_system_unitdir}/

    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants/
    ln -s ${systemd_system_unitdir}/hostapd@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/hostapd@ap0.service

}