DESCRIPTION = "Base application packagegroup"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = " \
	packagegroup-roslynos-base \
	packagegroup-roslynos-core \
	packagegroup-base-ap \ 
	packagegroup-base-dotnet \
	packagegroup-base-gpio \
"

RDEPENDS:${PN} = " \
	packagegroup-roslynos-core \ 
	packagegroup-base-ap \
	packagegroup-base-dotnet \
	packagegroup-base-gpio \
"

RDEPENDS:packagegroup-roslynos-core = "\
	iptables \
	sudo \
	nano \
	wget"

RDEPENDS:packagegroup-base-ap = "\
	iw \
	hostapd"

RDEPENDS:packagegroup-base-dotnet = "\
	vsdbg \
	dotnet-sdk-6.0 \
	dotnet-sdk-6.0-dev \
	dotnet-sdk-6.0-dbg \
	ldd \
	procps"

RDEPENDS:packagegroup-base-gpio = "\
	libgpiod \
	libgpiod-dev \
	libgpiod-tools"
