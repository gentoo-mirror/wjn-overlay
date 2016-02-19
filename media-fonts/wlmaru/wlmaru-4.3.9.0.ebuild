# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

MY_PN="${PN}2004emoji"

S_DIR="64146"
SP_DIR="64147"
SC_DIR="64148"
SCP_DIR="64149"

DESCRIPTION="Japanese rounded TTF includes emoji, based on Wadalab Font"
HOMEPAGE="http://osdn.jp/projects/jis2004/"
SRC_URI="mirror://osdn/jis2004/${S_DIR}/${MY_PN}${PV//./}.lzh
	mirror://osdn/jis2004/${SP_DIR}/${MY_PN}p${PV//./}.lzh
	mirror://osdn/jis2004/${SC_DIR}/${MY_PN/wlm/wlcm}${PV//./}.lzh
	mirror://osdn/jis2004/${SCP_DIR}/${MY_PN/wlm/wlcm}p${PV//./}.lzh"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/lha
	app-i18n/nkf"
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

DOCS="*.txt"

src_prepare() {
	for fn in *.txt; do
		nkf -S -w --overwrite ${fn}
	done
}
