FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://csharp.nanorc \
    file://nanorc \
"

inherit update-alternatives

EXTRA_OECONF:prepend = "--bindir=/bin"

ALTERNATIVE:${PN} = "editor"
ALTERNATIVE_LINK_NAME[editor] = "${base_bindir}/editor"
ALTERNATIVE_TARGET[editor] = "${base_bindir}/nano"
ALTERNATIVE_PRIORITY = "150"

do_install:append() {

    install -d ${D}${datadir}/nano
    install -m 644 ${WORKDIR}/csharp.nanorc ${D}${datadir}/nano

    install -d ${D}${sysconfdir}
	install -m 644 ${WORKDIR}/nanorc ${D}${sysconfdir}

}