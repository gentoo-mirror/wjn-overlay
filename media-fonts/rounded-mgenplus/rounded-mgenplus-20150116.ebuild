# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit font

DESCRIPTION="Japanese TrueType rounded font based on Source Hans Sans and M+"
HOMEPAGE="http://jikasei.me/font/rounded-mgenplus/"
SRC_URI="
	mirror://sourceforge.jp/users/7/7778/rounded-mgenplus-${PV}.7z
	mirror://sourceforge.jp/users/7/7776/rounded-x-mgenplus-${PV}.7z
	mirror://sourceforge.jp/users/7/7777/rounded-l-mgenplus-${PV}.7z
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="binchecks strip"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DEPEND="app-arch/p7zip"
RDEPEND=""

DOCS=( README_Rounded-MgenPlus.txt )
