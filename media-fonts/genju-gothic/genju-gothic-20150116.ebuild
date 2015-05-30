# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit font

DESCRIPTION=\
"Japanese TrueType rounded fonts based on Source Hans Sans (GennoKakuGothic)"
HOMEPAGE="http://jikasei.me/font/genjyuu/"
SRC_URI="
	mirror://sourceforge.jp/users/7/7762/genjyuugothic-${PV}.7z
	mirror://sourceforge.jp/users/7/7763/genjyuugothic-x-${PV}.7z
	mirror://sourceforge.jp/users/7/7761/genjyuugothic-l-${PV}.7z
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

DOCS=( README_GenJyuu.txt )
