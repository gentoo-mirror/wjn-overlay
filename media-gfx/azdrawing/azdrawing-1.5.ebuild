# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

DESCRIPTION="A painting software by drawing"
HOMEPAGE="http://azsky2.html.xdomain.jp/soft/azdrawing.html"
SRC_URI="http://azsky2.html.xdomain.jp/arc/azdrawing-1.5.tar.bz2"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libjpeg-turbo
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXi"
DEPEND=${COMMON_DEPEND}
RDEPEND=${COMMON_DEPEND}

RESTRICT="mirror"

DOCS=( NEWS README manual )
PATCHES=( "${FILESDIR}/${PN}-makefile.patch" )

src_compile() {
	emake prefix="${EPREFIX}/usr"
}

src_install() {
	emake prefix="${ED}/usr" install
	einstalldocs
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}