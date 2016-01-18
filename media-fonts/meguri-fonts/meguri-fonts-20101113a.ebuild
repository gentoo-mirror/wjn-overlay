# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

OSDN_DIR="8/8848"

DESCRIPTION="Meguri fonts are modified IPA and M+ fonts for Japanese"
HOMEPAGE="http://www.geocities.jp/ep3797/modified_fonts_01.html"
SRC_URI="mirror://osdn/users/${OSDN_DIR}/${P}.tar.lzma"

# IPAfont license because IPAfont is stricter than mplus-fonts
# FYI: http://d.hatena.ne.jp/itouhiro/20120607
LICENSE="IPAfont"
SLOT="0"
KEYWORDS=""

DEPEND="app-arch/xz-utils
	app-i18n/nkf"
RDEPEND=""

RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_prepare() {
	# convert from Shift_JIS to UTF-8
	nkf -S -w "${S}"/docs-ipa/Readme_IPAfont00302.txt > "${S}"/ipafont.txt

	# convert from EUC-JP to UTF-8
	nkf -E -w "${S}"/docs-mplus/README_J > "${S}"/mplus-ja.txt
}

src_install() {
	font_src_install
	dodoc ChangeLog README ipafont.txt mplus-ja.txt
	newdoc docs-mplus/README_E mplus-en.txt
}
