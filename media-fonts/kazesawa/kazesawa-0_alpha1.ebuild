# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

MY_PV="alpha-v1"
DESCRIPTION="Kazesawa Font: M+ with Source Sans Pro"
HOMEPAGE="https://kazesawa.github.io/"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/${MY_PV}/${PN}.zip
	-> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

DOCS="README.txt"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_install() {
	font_src_install
	dodoc "${DOCS}"
	docinto mplus 
	dodoc mplus/README*
	docinto source-sans-pro
	dodoc source-sans-pro/README.md
}

