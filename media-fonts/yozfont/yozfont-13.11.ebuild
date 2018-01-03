# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit font

MY_PN="YOzFont"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Japanese OpenType pen writing fonts made by Y.Oz"
HOMEPAGE="http://yozvox.web.fc2.com/"
SRC_URI="http://yozvox.web.fc2.com/${MY_P}.7z"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/p7zip"
RDEPEND=""

S="${WORKDIR}/${MY_PN}"
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttc"
FONT_S=${S}

DOCS="Readme.txt Readme_E.txt"

src_prepare() {
	for f in *.TTC; do
		mv $f ${f%.TTC}.ttc
	done
}
