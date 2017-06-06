# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

OSDN_DIR="8/8846"

DESCRIPTION="Komatuna fonts are modified Konatu and M+ fonts for Japanese"
HOMEPAGE="http://www.geocities.jp/ep3797/modified_fonts_01.html"
SRC_URI="mirror://osdn/users/${OSDN_DIR}/${P}.tar.lzma"

# Konatu has MIT license after 2012-12-18.
# See http://www.masuseki.com/?u=be/konatu.htm#license
LICENSE="MIT mplus-fonts"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/xz-utils
	app-i18n/nkf"
RDEPEND=""

RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_prepare() {
	# convert from EUC-JP to UTF-8
	nkf -E -w "${S}"/docs-mplus/README_J > "${S}"/mplus-ja.txt
}

src_install() {
	font_src_install
	dodoc ChangeLog README mplus-ja.txt
	newdoc docs-konatu/README.txt konatu-en.txt
	newdoc docs-konatu/README_Japanese.txt konatu-ja.txt
	newdoc docs-mplus/README_E mplus-en.txt
}
