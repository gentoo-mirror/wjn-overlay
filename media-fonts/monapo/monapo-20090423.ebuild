# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

DESCRIPTION="combined font of ja-ipafonts (GothicP) and monafont"
HOMEPAGE="http://www.geocities.jp/ep3797/modified_fonts_01.html"
SRC_URI="http://www.geocities.jp/ep3797/snapshot/modified_fonts/${P}.tar.bz2"

# IPAfont license because IPAfont is stricter than mplus-fonts
# FYI: http://d.hatena.ne.jp/itouhiro/20120607
LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-i18n/nkf"
RDEPEND=""

RESTRICT="binchecks mirror strip"

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
