DESCRIPTION = "Microsoft .NET Core 7.0 SDK including .NET Runtime"
HOMEPAGE = "https://dotnet.microsoft.com/en-us/download/dotnet/7.0"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# DOTNET_FETCH_ID = "72ec0dc2-f425-48c3-97f1-dc83740ba400/78e8fa01fa9987834fa01c19a23dd2e7"

# SRC_URI[sha256sum] = "3e19e27c3a82fbd2f8513c8f2ada3f7e1fc64fe266125c8ce5b7b1ce7db7676e"
# SRC_URI = " \
#     https://download.visualstudio.microsoft.com/download/pr/${DOTNET_FETCH_ID}/dotnet-sdk-${PV}-linux-arm64.tar.gz;unpack=0 \
#     file://dotnet-sdk.sh \
# "

# COMPATIBLE_HOST ?= "(aarch64).*-linux"

DOTNET_FETCH_ID = "54b057ec-36ef-4808-a436-50ee3fa39a44/87d696a761176b721daaf8ab9761c9c8"

SRC_URI[sha256sum] = "c8bb3651d51a0044321e4a25771d2152c5c6f70fa0009cd65d27913f3b64d670"
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