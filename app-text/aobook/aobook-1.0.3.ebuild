# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Viewer for Aozora Bunko (Japanese electric library)"
HOMEPAGE="http://azsky2.html.xdomain.jp/soft/aobook.html"
SRC_URI="http://azsky2.html.xdomain.jp/arc/aobook-1.0.3.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libjpeg-turbo
	media-libs/libpng:0
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext"
DEPEND=${RDEPEND}

RESTRICT="mirror"

DOCS=( AUTHORS ChangeLog NEWS README doc/manual.html )