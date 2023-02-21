FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += " \
   file://wpa_supplicant-ap0.conf \
   file://wpa_supplicant-nl80211-wlan0.conf"

#SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN} = "wpa_supplicant-nl80211@wlan0.service"
SYSTEMD_AUTO_ENABLE:${PN} = "disable"

do_install:append () {
      
   install -d ${D}${sysconfdir}/wpa_supplicant
   install -m 644 ${WORKDIR}/wpa_supplicant-ap0.conf ${D}${sysconfdir}/wpa_supplicant
   
   install -d ${D}${sysconfdir}/wpa_supplicant
   install -m 600 ${WORKDIR}/wpa_supplicant-nl80211-wlan0.conf ${D}${sysconfdir}/wpa_supplicant

   install -d ${D}${sysconfdir}/systemd/system/multi-user.target.wants/
   ln -s ${systemd_unitdir}/system/wpa_supplicant@.service ${D}${sysconfdir}/systemd/system/multi-user.target.wants/wpa_supplicant-nl80211@wlan0.service

}