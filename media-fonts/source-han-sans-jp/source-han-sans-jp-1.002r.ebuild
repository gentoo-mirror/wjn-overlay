# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit font

MY_PN="SourceHanSansJP"

DESCRIPTION="Subset OTF of GennoKakuGothic, a Japanese font by Adobe and Google"
HOMEPAGE="https://github.com/adobe-fonts/source-han-sans"
SRC_URI="
	https://raw.githubusercontent.com/adobe-fonts/${PN}/1.002R/SubsetOTF/${MY_PN}.zip
	https://github.com/adobe-fonts/${PN}/raw/1.002R/README.md
	https://raw.githubusercontent.com/adobe-fonts/${PN}/1.002R/${MY_PN/JP/}DesignGuide.pdf
	https://raw.githubusercontent.com/adobe-fonts/${PN}/1.002R/${MY_PN/JP/}ReadMe.pdf
	"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="binchecks strip"

DEPEND=""
RDEPEND=""
S="${DISTDIR}"

DOCS=( README.md )

FONT_SUFFIX="otf"
FONT_S="${WORKDIR}/${MY_PN}"

src_install() {
	font_src_install
	dodoc ${MY_PN/JP/}DesignGuide.pdf ${MY_PN/JP/}ReadMe.pdf
}