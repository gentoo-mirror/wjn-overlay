# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A full-color painting software"
HOMEPAGE="http://azpainter.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/62214/${P}-src.tar.bz2"
LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libjpeg-turbo
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXi
	"

DEPEND="${RDEPEND}
	app-arch/bzip2
	sys-apps/sed
	sys-devel/gcc
"

src_prepare() {
	sed -i 's_prefix := /usr/local_prefix := '${EPREFIX}'/usr_' Makefile
	mkdir -p "_obj/azxc"
}

src_compile() {
	emake datadir=/usr/share/${PN}
}

src_install() {
	einstall datadir=${ED}/usr/share/${PN}
	dodoc README NEWS
}

