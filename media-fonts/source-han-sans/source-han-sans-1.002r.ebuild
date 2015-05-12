# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

MY_PN="SourceHanSans"

DESCRIPTION="an OpenType/CFF Pan-CJK fonts by Adobe and Google. SuperOTC ver."
HOMEPAGE="https://github.com/adobe-fonts/source-han-sans"
SRC_URI="
	https://raw.githubusercontent.com/adobe-fonts/${PN}/1.002R/SuperOTC/${MY_PN}.ttc.zip
	https://github.com/adobe-fonts/${PN}/raw/1.002R/README.md
	https://raw.githubusercontent.com/adobe-fonts/${PN}/1.002R/${MY_PN}DesignGuide.pdf
	https://raw.githubusercontent.com/adobe-fonts/${PN}/1.002R/${MY_PN}ReadMe.pdf
	"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="binchecks strip"

DEPEND="app-arch/unzip"
RDEPEND=""
S="${WORKDIR}"

DOCS=( README.md )

FONT_SUFFIX="ttc"
FONT_S="${S}"

src_unpack() {
	unpack ${MY_PN}.ttc.zip
	cp "${DISTDIR}"/*.pdf "${DISTDIR}"/README.md "${S}"
}

src_install() {
	font_src_install
	dodoc ${MY_PN}DesignGuide.pdf ${MY_PN}ReadMe.pdf
}