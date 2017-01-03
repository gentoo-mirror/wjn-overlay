# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

OSDN_DIR="9/9097"

DESCRIPTION="UmePlus CL fonts are modified Ume CL and M+ fonts for Japanese"
HOMEPAGE="http://www.geocities.jp/ep3797/modified_fonts_01.html"
SRC_URI="mirror://osdn/users/${OSDN_DIR}/${P}.tar.xz"

# mplus-fonts license is applied to M+ FONTS as well as UmeFont
LICENSE="mplus-fonts"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_install(){
	font_src_install
	dodoc ChangeLog README
	docinto docs-mplus
	dodoc docs-mplus/README*
	docinto docs-ume
	dodoc docs-ume/license.html
}