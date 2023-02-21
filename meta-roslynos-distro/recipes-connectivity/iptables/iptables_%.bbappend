FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://ip6tables.rules \
    file://iptables.rules \
"

do_install:append() {

    install -d ${D}${sysconfdir}/iptables
    install -m 644 ${WORKDIR}/ip6tables.rules ${D}${sysconfdir}/iptables
    install -m 644 ${WORKDIR}/iptables.rules ${D}${sysconfdir}/iptables

}