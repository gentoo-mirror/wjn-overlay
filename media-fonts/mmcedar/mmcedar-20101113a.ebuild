# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

DESCRIPTION="MMCedar are combined fonts that use Motoya L Cedar and M+ fonts"
HOMEPAGE="http://www.geocities.jp/ep3797/modified_fonts_01.html"
SRC_URI="mirror://sourceforge/mdk-ut/${P}.tar.lzma"

LICENSE="Apache-2.0 mplus-fonts"
SLOT="0"
KEYWORDS=""

DEPEND="app-arch/xz-utils
	app-i18n/nkf"
RDEPEND=""

RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_prepare() {
	# convert from EUC-JP to UTF-8
	nkf -E -w "${S}"/doc-mplus/README_J > "${S}"/mplus-ja.txt
}

src_install() {
	font_src_install
	dodoc ChangeLog README mplus-ja.txt
	newdoc doc-MTLc3m/README.txt motoya.txt
	newdoc doc-mplus/README_E mplus-en.txt
}
