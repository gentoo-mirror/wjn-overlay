# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit font

DESCRIPTION="UmePlus CL fonts are modified Ume CL and M+ fonts for Japanese"
HOMEPAGE="http://www.geocities.jp/ep3797/modified_fonts_01.html"
SRC_URI="mirror://sourceforge/mdk-ut/${P}.tar.lzma"

LICENSE="mplus-fonts public-domain"
SLOT="0"
KEYWORDS=""

DEPEND="app-arch/xz-utils"
RDEPEND=""

RESTRICT="binchecks strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_install() {
	font_src_install
	dodoc ChangeLog README
	newdoc docs-mplus/README_E mplus-en.txt
	newdoc docs-mplus/README_J mplus-ja.txt
	newdoc docs-ume/license.html ume.html
}
