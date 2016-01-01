# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font versionator

MY_PN="${PN/-/}"
MY_PV="$(get_version_component_range 3-)"
MPLUS_VER="059"

S_DIR="8/8634"

DESCRIPTION="Japanese TrueType font based on Source Hans Sans (GennoKakuGothic)"
HOMEPAGE="http://jikasei.me/font/genshin/"
SRC_URI="mirror://osdn/users/${S_DIR}/${MY_PN}-${MY_PV}.7z"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""
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
