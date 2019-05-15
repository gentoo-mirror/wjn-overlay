# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

OSDN_DIR="71050"

DESCRIPTION="Simple 8bit color paint software"
HOMEPAGE="http://azsky2.html.xdomain.jp/linux/azpainterb/index.html"
SRC_URI="mirror://osdn/${PN}/${OSDN_DIR}/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libjpeg-turbo
	media-libs/libpng:0
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXi"
DEPEND=${COMMON_DEPEND}
RDEPEND=${COMMON_DEPEND}

RESTRICT="mirror"

DOCS=( AUTHORS ChangeLog NEWS README README_ja html translation )

src_prepare() {
	default
	mv manual html
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}