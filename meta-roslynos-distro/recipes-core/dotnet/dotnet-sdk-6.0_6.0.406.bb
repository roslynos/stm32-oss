DESCRIPTION = "Microsoft .NET Core 6.0 SDK including .NET Runtime"
HOMEPAGE = "https://dotnet.microsoft.com/en-us/download/dotnet/6.0"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

DOTNET_FETCH_ID = "57c99686-6bce-48c7-b69c-91e0be60165c/69e812835ab62d1f1773a71ee943d9a7"

SRC_URI[sha256sum] = "6737d0de160c7c923484e351f195aae4987bf430ec3c8787af495b39254b5e5d"
SRC_URI = " \
    https://download.visualstudio.microsoft.com/download/pr/${DOTNET_FETCH_ID}/dotnet-sdk-${PV}-linux-arm.tar.gz;unpack=0 \
    file://dotnet-sdk.sh \
"

COMPATIBLE_HOST ?= "(arm).*-linux"

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = '1' 

DEPENDS += "\
    zlib \
"

RDEPENDS:${PN} = "\
    glibc \
    icu \
    krb5 \
    libgcc \
    libstdc++ \
    openssl \
"

FILES:${PN} += "\
    ${datadir}/dotnet \
"

FILES:${PN}-dev = "\
    ${datadir}/dotnet/sdk \
    ${datadir}/dotnet/sdk-manifests \
    ${datadir}/dotnet/templates \
"

FILES:${PN}-dbg = "\
    ${datadir}/dotnet/.debug \
"

INSANE_SKIP:${PN} = "file-rdeps staticdev libdir"
INSANE_SKIP:${PN}-dbg = "libdir"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
    
    install -d ${D}${datadir}/dotnet
    tar --no-same-owner -xpvzf ${WORKDIR}/dotnet-sdk-${PV}-linux-arm.tar.gz -C ${D}${datadir}/dotnet
    chmod +x ${D}${datadir}/dotnet/dotnet

    # Symlinks
    install -d ${D}${bindir}
    ln -rs ${D}${datadir}/dotnet/dotnet ${D}${bindir}/dotnet
}

do_install:append() {
    
    install -d ${D}${sysconfdir}/profile.d
    install -m 644 ${WORKDIR}/dotnet-sdk.sh ${D}${sysconfdir}/profile.d
}