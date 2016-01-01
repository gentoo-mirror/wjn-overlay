# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

MY_PN="${PN}2004emoji"
S_DIR="62896"
SP_DIR="62897"
SC_DIR="62898"
SCP_DIR="62899"

DESCRIPTION="a Japanese rounded gothic TrueType fonts based on Wadalab font"
HOMEPAGE="http://osdn.jp/projects/jis2004/"
SRC_URI="mirror://osdn/jis2004/${S_DIR}/${MY_PN}${PV//./}.lzh
	mirror://osdn/jis2004/${SP_DIR}/${MY_PN}p${PV//./}.lzh
	mirror://osdn/jis2004/${SC_DIR}/${MY_PN/wlm/wlcm}${PV//./}.lzh
	mirror://osdn/jis2004/${SCP_DIR}/${MY_PN/wlm/wlcm}p${PV//./}.lzh"

LICENSE="freedist"
SLOT="0"
KEYWORDS=""

DEPEND="app-arch/lha
	app-i18n/nkf"
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_prepare() {
	for fn in *.txt; do
		cp $fn ${fn%.txt}
		nkf -S -w ${fn%.txt} > $fn
	done
}

src_install() {
	font_src_install
	dodoc *.txt
}
