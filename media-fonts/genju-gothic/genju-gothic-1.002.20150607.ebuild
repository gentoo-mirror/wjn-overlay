# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font versionator

MY_PN="${PN/genju-/genjyuu}"
MY_PV="$(get_version_component_range 3-)"
MPLUS_VER="059"

S_DIR="8/8636"
S_DIR_L="8/8635"
S_DIR_X="8/8638"

DESCRIPTION=\
"Japanese TrueType rounded fonts based on Source Hans Sans (GennoKakuGothic)"
HOMEPAGE="http://jikasei.me/font/genjyuu/"
SRC_URI="mirror://osdn/users/${S_DIR}/${MY_PN}-${MY_PV}.7z
	rounded-l? (
		mirror://osdn/users/${S_DIR_L}/${MY_PN}-l-${MY_PV}.7z )
	rounded-x? (
		mirror://osdn/users/${S_DIR_X}/${MY_PN}-x-${MY_PV}.7z )"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""
IUSE="rounded-l rounded-x"

RESTRICT="binchecks mirror strip"

S=${WORKDIR}

FONT_SUFFIX="ttf"
FONT_S=${S}

DEPEND="app-arch/p7zip"
RDEPEND=""

src_install() {
	font_src_install
	dodoc README*.txt
	newdoc mplus-TESTFLIGHT-${MPLUS_VER}/README_E mplus-en.txt
	newdoc mplus-TESTFLIGHT-${MPLUS_VER}/README_J mplus-ja.txt
}
