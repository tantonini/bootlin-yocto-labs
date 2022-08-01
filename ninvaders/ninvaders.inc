DEPENDS = "ncurses"
LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://gpl.txt;md5=393a5ca445f6965873eca0259a17f833"
SRC_URI = "${SOURCEFORGE_MIRROR}/${BPN}/${BPN}/${PV}/${BPN}-${PV}.tar.gz"

EXTRA_OEMAKE:append = "-e"
CFLAGS:append = " -fcommon"

do_install() {
        install -d ${D}${bindir}
        install -m 755 nInvaders ${D}${bindir}/ninvaders
}
