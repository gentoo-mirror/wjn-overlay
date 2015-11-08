# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Viewer for Aozora Bunko (Japanese electric library)"
HOMEPAGE="http://azsky2.html.xdomain.jp/linux/aobook/index.html"
SRC_URI="mirror://osdn/${PN}/62557/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

RDEPEND="media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libjpeg-turbo
	media-libs/libpng:0
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext"

DEPEND=${RDEPEND}

DOCS=( AUTHORS ChangeLog NEWS README manual.html )
