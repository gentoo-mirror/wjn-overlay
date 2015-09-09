# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

DESCRIPTION="combined font of ja-ipafonts (GothicP) and monafont"
HOMEPAGE="http://www.geocities.jp/ep3797/modified_fonts_01.html"
SRC_URI="http://www.geocities.jp/ep3797/snapshot/modified_fonts/${P}.tar.bz2"

LICENSE="IPAfont public-domain"
SLOT="0"
KEYWORDS=""

DEPEND="app-i18n/nkf"
RDEPEND=""

RESTRICT="binchecks strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_prepare() {
	# convert from Shift_JIS to UTF-8
	nkf -S -w "${S}"/docs-mona/README-ttf.txt > "${S}"/monafont.txt
}

src_install() {
	font_src_install
	dodoc ChangeLog README monafont.txt
	newdoc docs-ipafont/Readme00301.txt ipafont.txt
}
