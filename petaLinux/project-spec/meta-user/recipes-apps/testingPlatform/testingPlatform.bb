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
           file://www/lang/b28n.js \
           file://www/lang/webcam.js \
           file://www/js/jquery-3.4.1.min.js \
           file://www/js/bootstrap.bundle.min.js \
           file://www/css/bootstrap.min.css \
           file://par/test.json \
	"

S = "${WORKDIR}"

do_install() {
	     install -d ${D}/${bindir}
	     install -m 0755 ${S}/testingPlatform ${D}/${bindir}
         install -d ${D}/srv/www
         install -m 0644 ${S}/www/index.html ${D}/srv/www
         install -d ${D}/srv/www/cgi-bin
         install -m 0755 ${S}/www/cgi-bin/gpio ${D}/srv/www/cgi-bin
         install -d ${D}/srv/www/lang
         install -m 0755 ${S}/www/lang/b28n.js ${D}/srv/www/lang
         install -m 0755 ${S}/www/lang/webcam.js ${D}/srv/www/lang
         install -d ${D}/srv/www/js
         install -m 0755 ${S}/www/js/jquery-3.4.1.min.js ${D}/srv/www/js
         install -m 0755 ${S}/www/js/bootstrap.bundle.min.js ${D}/srv/www/js
         install -d ${D}/srv/www/css
         install -m 0755 ${S}/www/css/bootstrap.min.css ${D}/srv/www/css
         install -d ${D}/home/root/par
         install -m 0644 ${S}/par/test.json ${D}/home/root/par
}

FILES_${PN} += "srv/www/*"
FILES_${PN} += "home/root/par/*"
#RDEPENDS_${PN} += "libc.so.6"
