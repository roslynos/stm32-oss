DESCRIPTION = "Microsoft .NET Core 7.0 SDK including .NET Runtime"
HOMEPAGE = "https://dotnet.microsoft.com/en-us/download/dotnet/7.0"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

DOTNET_FETCH_ID = "43b25a51-637e-492a-a0b9-9cd406f843ce/fda51e8b6a57bfc372e4a62ce3185d6e"

SRC_URI[sha256sum] = "74ca8771792c98e757a73e042a1706a432b68dd92db27b096c22f32f3c392275"
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