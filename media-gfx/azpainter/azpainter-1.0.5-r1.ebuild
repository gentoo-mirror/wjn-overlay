# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="A full-color painting software"
HOMEPAGE="http://azsky2.html.xdomain.jp/linux/azpainter/"
SRC_URI="mirror://sourceforge.jp/${PN}/62214/${P}-src.tar.bz2"

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
DEPEND="${COMMON_DEPEND}
	sys-apps/sed"
RDEPEND=${COMMON_DEPEND}


src_prepare() {
	sed -i 's_prefix := /usr/local_prefix := '${EPREFIX}'/usr_' Makefile
	epatch "${FILESDIR}/${P}-rulepos.patch"
	mkdir -p "_obj/azxc"
}

src_compile() {
	emake datadir="/usr/share/${PN}"
}

src_install() {
	einstall datadir="${ED}/usr/share/${PN}"
	dodoc NEWS README
}
