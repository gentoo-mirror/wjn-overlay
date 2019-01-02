# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

MY_PN="ki_kokumin"

DESCRIPTION="Japanese mincho TTF based on IPAex, has smaller kana letter"
HOMEPAGE="http://freefonts.jp/font-koku-min.html"
SRC_URI="http://freefonts.jp/dl_3qa5ju5a45/${MY_PN}.zip"

LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip
	app-i18n/nkf"
RDEPEND=""

S="${WORKDIR}/${MY_PN}"
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_prepare() {
	for fn in *.txt ipaexfont/*.txt; do
		cp $fn ${fn%.txt}
		nkf -S -w ${fn%.txt} > $fn
	done
}

src_install() {
	font_src_install
	dodoc *.txt
	newdoc ipaexfont/Readme_IPAexfont00201.txt IPAexfont.txt
}
