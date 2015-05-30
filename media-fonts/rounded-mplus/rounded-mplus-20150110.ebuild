# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit font

DESCRIPTION="Japanese TrueType rounded gothic fonts based on mplus-fonts."
HOMEPAGE="http://jikasei.me/font/rounded-mplus/"
SRC_URI="
	mirror://sourceforge.jp/users/7/7708/rounded-mplus-${PV}.7z
	mirror://sourceforge.jp/users/7/7709/rounded-x-mplus-${PV}.7z
	mirror://sourceforge.jp/users/7/7707/rounded-l-mplus-${PV}.7z
	"

LICENSE="mplus-fonts"
SLOT="0"
KEYWORDS=""
RESTRICT="binchecks strip"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DEPEND="app-arch/p7zip"
RDEPEND=""

DOCS=( README_E_Rounded.txt README_J_Rounded.txt )
