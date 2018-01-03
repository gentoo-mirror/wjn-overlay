# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit font

MY_PN="twobythree"
MY_P="${MY_PN}${PV}"

DESCRIPTION="Japanese TrueType two-thirds-width mincho and gothic fonts based on IPA fonts."
HOMEPAGE="http://opentype.jp/twobythreefont.htm"
SRC_URI="http://opentype.jp/bin/${MY_PN}.zip"

LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="binchecks mirror strip"

DEPEND="app-arch/unzip"
RDEPEND=""
S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DOCS="Readme.txt"
