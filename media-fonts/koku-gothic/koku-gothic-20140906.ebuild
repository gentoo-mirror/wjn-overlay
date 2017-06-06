# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

MY_PN="ki_kokugo"

DESCRIPTION="Japanese gothic TTF based on M+ and SourceHanSans, has smaller kana"
HOMEPAGE="http://freefonts.jp/font-koku-go.html"
SRC_URI="http://freefonts.jp/dl_3qa5ju5a45/${MY_PN}.zip"

LICENSE="Apache-2.0 mplus-fonts"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip
	app-i18n/nkf"
RDEPEND=""

S="${WORKDIR}"
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_prepare() {
	for fn in readme.txt; do
		cp $fn ${fn%.txt}
		nkf -S -w ${fn%.txt} > $fn
	done
}

src_install() {
	font_src_install
	dodoc readme.txt
	newdoc mplus-TESTFLIGHT-057/README_J mplus-ja.txt
	newdoc mplus-TESTFLIGHT-057/README_E mplus-en.txt
}
