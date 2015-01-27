# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit font

DESCRIPTION="an OpenType/CFF Pan-CJK fonts by Adobe and Google. SuperOTC ver."
HOMEPAGE="https://github.com/adobe-fonts/source-han-sans"
SRC_URI="
	https://raw.githubusercontent.com/adobe-fonts/source-han-sans/1.001R/SuperOTC/SourceHanSans.ttc.zip
	https://github.com/adobe-fonts/source-han-sans/raw/1.001R/README.md
	https://raw.githubusercontent.com/adobe-fonts/source-han-sans/1.001R/SourceHanSansDesignGuide.pdf
	https://raw.githubusercontent.com/adobe-fonts/source-han-sans/1.001R/SourceHanSansReadMe.pdf
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
	unpack SourceHanSans.ttc.zip
	cp "${DISTDIR}"/*.pdf "${DISTDIR}"/README.md "${S}"
}

src_install() {
	font_src_install
	dodoc SourceHanSansDesignGuide.pdf SourceHanSansReadMe.pdf
}

