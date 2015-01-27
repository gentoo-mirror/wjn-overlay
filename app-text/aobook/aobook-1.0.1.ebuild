# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Viewer for Aozora Bunko (Japanese electric library)"
HOMEPAGE="http://azsky2.html.xdomain.jp/linux/aobook/index.html"
SRC_URI="mirror://sourceforge.jp/${PN}/62557/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libjpeg-turbo
	media-libs/libpng
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	"

DEPEND="${RDEPEND}
	app-arch/bzip2
	sys-devel/gcc
	sys-devel/make
	"

DOCS=( AUTHORS ChangeLog NEWS README manual.html )

