# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

MY_PN=${PN%-otf}

GOTHIC_VER="20150215"
MINCHO_VER="20150515b"
P_GOTHIC="${MY_PN%-fonts}-gothic-otf-${GOTHIC_VER}"
P_MINCHO="${MY_PN%-fonts}-mincho-otf-${MINCHO_VER}"

GOTHIC_DIR="62786"
MINCHO_DIR="63262"

DESCRIPTION="Sawarabi-fonts is a Japanese OTF font family"
HOMEPAGE="http://osdn.jp/projects/sawarabi-fonts/"
SRC_URI="
	mirror://sourceforge.jp/${MY_PN}/${GOTHIC_DIR}/${P_GOTHIC}.tar.xz
	mirror://sourceforge.jp/${MY_PN}/${MINCHO_DIR}/${P_MINCHO}.tar.xz"

LICENSE="CC-BY-3.0"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks strip"

FONT_SUFFIX="otf"
FONT_S=${S}

src_prepare() {
	for dn in *; do
		mv ${dn}/*.otf ./
		for fn in en ja; do
			mv ${dn}/README_${fn}.txt \
				${dn}_${fn}.txt
		done
	done
}

src_install() {
	font_src_install
	dodoc *.txt
}
