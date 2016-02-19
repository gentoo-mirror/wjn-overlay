# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font versionator

MY_PV="$(get_version_component_range 3-)"
MPLUS_VER="$(get_version_component_range 2)"

S_DIR="8/8597"

DESCRIPTION="Japanese TrueType font based on Source Hans Sans and M+"
HOMEPAGE="http://jikasei.me/font/mgenplus/"
SRC_URI="mirror://osdn/users/${S_DIR}/${PN}-${MY_PV}.7z"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
