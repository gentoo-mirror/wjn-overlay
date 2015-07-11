# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit font

MY_PN="${PN%cho}"

DESCRIPTION="a Japanese mincho OpenType font with IPAexmincho kanji chars"
HOMEPAGE="http://font.gloomy.jp/honoka-mincho-dl.html"
SRC_URI="http://font.gloomy.jp/dl-font-6w64rids/${MY_PN}.zip"

LICENSE="IPAfont"
SLOT="0"
KEYWORDS=""

DEPEND="app-arch/unzip
	app-i18n/nkf"
RDEPEND=""

S="${WORKDIR}/${MY_PN}"
RESTRICT="binchecks strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_prepare() {
	for fn in *.txt ipaexfont/*.txt; do
		cp $fn ${fn%.txt}
		nkf -S -w ${fn%.txt} > $fn
	done
	mv *.txt readme.txt
}

src_install() {
	font_src_install
	dodoc readme.txt
	newdoc ipaexfont/Readme_IPAexfont00201.txt IPAexfont.txt
}