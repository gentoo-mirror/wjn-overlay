# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font versionator

MY_PV="$(get_version_component_range 3-)"
MPLUS_VER="$(get_version_component_range 2)"

S_DIR="8/8569"
S_DIR_L="8/8568"
S_DIR_X="8/8570"

DESCRIPTION="Japanese TrueType rounded gothic fonts based on mplus-fonts"
HOMEPAGE="http://jikasei.me/font/rounded-mplus/"
SRC_URI="mirror://osdn/users/${S_DIR}/${PN}-${MY_PV}.7z
	rounded-l? (
		mirror://osdn/users/${S_DIR_L}/${PN/d-m/d-l-m}-${MY_PV}.7z )
	rounded-x? (
		mirror://osdn/users/${S_DIR_X}/${PN/d-m/d-x-m}-${MY_PV}.7z )"

LICENSE="mplus-fonts"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rounded-l rounded-x"

RESTRICT="binchecks mirror strip"

S=${WORKDIR}

FONT_SUFFIX="ttf"
FONT_S=${S}

DEPEND="app-arch/p7zip"
RDEPEND=""

src_install() {
	font_src_install
	dodoc *.txt
	newdoc mplus-TESTFLIGHT-${MPLUS_VER}/README_E mplus-en.txt
	newdoc mplus-TESTFLIGHT-${MPLUS_VER}/README_J mplus-ja.txt
}
