FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:roslynos = " \
    file://udhcpd.conf \
    file://udhcpd.leases \
    file://udhcpd.service \
"

RDEPENDS:${PN} = "\
    busybox \
"
inherit systemd
inherit features_check

SYSTEMD_PACKAGES += "${PN}"
SYSTEMD_SERVICE:${PN} = "udhcpd.service"
SYSTEMD_AUTO_ENABLE:${PN} = "disable"

REQUIRED_DISTRO_FEATURES = "systemd"

do_install:append() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/udhcpd.conf ${D}${sysconfdir}/udhcpd.conf

    install -d ${D}${localstatedir}/lib/misc
    install -m 0644 ${WORKDIR}/udhcpd.leases ${D}${localstatedir}/lib/misc/udhcpd.leases
      
    install -d -m 0755 ${D}${systemd_system_unitdir}/
    install -m 0644 ${WORKDIR}/udhcpd.service ${D}${systemd_system_unitdir}/

    install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants/
    ln -s ${systemd_system_unitdir}/udhcpd.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/udhcpd.service
}