# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit gnome2-utils

MY_PV=${PV/_beta/b}
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A full-color painting software"
HOMEPAGE="http://azsky2.html.xdomain.jp/linux/azpainter/"
SRC_URI="http://azsky2.html.xdomain.jp/memo/${MY_P}.tar.bz2"

LICENSE="GPL-3 BSD"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libjpeg-turbo
	media-libs/libpng:*
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXi"
DEPEND=${COMMON_DEPEND}
RDEPEND=${COMMON_DEPEND}

S="${WORKDIR}/${MY_P}"
RESTRICT="mirror"

DOCS=( ChangeLog NEWS README README.ja translation )

# src_compile() {
# 	emake datadir="/usr/share/${PN}"
# }

# src_install() {
# 	emake prefix="${ED}/usr" datadir="${ED}/usr/share/${PN}" install
# 	einstalldocs
# }

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}