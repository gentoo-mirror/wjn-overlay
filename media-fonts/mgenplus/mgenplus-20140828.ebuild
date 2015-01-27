# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit font

DESCRIPTION="Japanese TrueType font based on Source Hans Sans and M+"
HOMEPAGE="http://jikasei.me/font/mgenplus/"
SRC_URI="mirror://sourceforge.jp/users/7/7134/mgenplus-20140828.7z"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="binchecks strip"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DEPEND="app-arch/p7zip"
RDEPEND=""

DOCS=( README_MgenPlus.txt )

