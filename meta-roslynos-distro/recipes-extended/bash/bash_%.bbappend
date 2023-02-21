ALTERNATIVE_PRIORITY[sh] = "100"
ALTERNATIVE_TARGET[sh] = "${base_bindir}/bash.bash"

ALTERNATIVE:${PN} += "bash"
ALTERNATIVE_PRIORITY[bash] = "40"
ALTERNATIVE_LINK_NAME[bash] = "${base_bindir}/bash"