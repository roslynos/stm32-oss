FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:roslynos = " \
    file://i2c.cfg \
    file://less.cfg \
    file://udhcpd.cfg \
"

RDEPENDS:${PN} = "\
    busybox \
"