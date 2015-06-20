# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

MY_PN="SourceHanSans"
MY_PV="${PV}R"

DESCRIPTION="an OpenType/CFF Pan-CJK fonts by Adobe and Google. SuperOTC ver."
HOMEPAGE="https://github.com/adobe-fonts/source-han-sans"
SRC_URI="
	https://github.com/adobe-fonts/${PN}/raw/${MY_PV}/SuperOTC/${MY_PN}.ttc.zip
		-> ${P}.zip
	https://github.com/adobe-fonts/${PN}/raw/${MY_PV}/README.md
		-> ${P}-README.md
	https://github.com/adobe-fonts/${PN}/raw/${MY_PV}/${MY_PN}DesignGuide.pdf
		-> ${P}-DesignGuide.pdf
	https://github.com/adobe-fonts/${PN}/raw/${MY_PV}/${MY_PN}ReadMe.pdf
		-> ${P}-ReadMe.pdf
	"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""
RESTRICT="binchecks strip"

DEPEND="app-arch/unzip"
RDEPEND=""
S=${WORKDIR}

FONT_SUFFIX="ttc"
FONT_S=${S}

src_unpack() {
	unpack ${P}.zip
	cp "${DISTDIR}"/${P}-*.pdf "${DISTDIR}"/${P}-README.md "${S}"
}

src_install() {
	font_src_install
	newdoc ${P}-DesignGuide.pdf DesignGuide.pdf
	newdoc ${P}-ReadMe.pdf ReadMe.pdf
	newdoc ${P}-README.md README.md
}
