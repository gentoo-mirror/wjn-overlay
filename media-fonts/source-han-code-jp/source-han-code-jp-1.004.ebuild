# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

MY_PN="SourceHanCodeJP"
MY_PV="${PV}R"
DESCRIPTION="Derivative of Source-Han-Sans replaced Latin letters to fixed"
HOMEPAGE="https://github.com/adobe-fonts/source-han-code-jp/"
SRC_URI="https://github.com/adobe-fonts/${PN}/archive/${MY_PV}.zip -> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}"
RESTRICT="binchecks mirror strip"

DOCS=( "README.md" "relnotes.txt" )

FONT_SUFFIX="otf"
FONT_S="${S}/OTF/${MY_PN}"

pkg_postinst (){
	elog 'This fonts will be listed as "源ノ角ゴシック Code JP".'
}