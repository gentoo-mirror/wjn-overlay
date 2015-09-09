# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font versionator

MY_PV="$(get_version_component_range 3-)"
MPLUS_VER="$(get_version_component_range 2)"

S_DIR="8/8598"
S_DIR_L="8/8600"
S_DIR_X="8/8599"

DESCRIPTION="Japanese TrueType rounded font based on Source Hans Sans and M+"
HOMEPAGE="http://jikasei.me/font/rounded-mgenplus/"
SRC_URI="mirror://sourceforge.jp/users/${S_DIR}/${PN}-${MY_PV}.7z
	rounded-l? (
		mirror://sourceforge.jp/users/${S_DIR_L}/${PN/d-m/d-l-m}-${MY_PV}.7z )
	rounded-x? (
		mirror://sourceforge.jp/users/${S_DIR_X}/${PN/d-m/d-x-m}-${MY_PV}.7z )"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""
IUSE="rounded-l rounded-x"

RESTRICT="binchecks strip"

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
