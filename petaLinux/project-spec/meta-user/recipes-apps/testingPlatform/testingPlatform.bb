#
# This file is the testingPlatform recipe.
#

SUMMARY = "Simple testingPlatform application"
SECTION = "PETALINUX/apps"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://testingPlatform \
           file://www/index.html \
           file://www/cgi-bin/gpio \
	"

S = "${WORKDIR}"

do_install() {
	     install -d ${D}/${bindir}
	     install -m 0755 ${S}/testingPlatform ${D}/${bindir}
         install -d ${D}/srv/www
         install -m 0644 ${S}/www/index.html ${D}/srv/www
         install -d ${D}/srv/www/cgi-bin
         install -m 0755 ${S}/www/cgi-bin/gpio ${D}/srv/www/cgi-bin
}

FILES_${PN} += "srv/www/*"
