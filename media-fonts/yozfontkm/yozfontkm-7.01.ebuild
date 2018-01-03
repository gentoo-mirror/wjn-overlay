# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit font

MY_PN="YOzFontKM"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Japanese OpenType brush fonts made by Y.Oz"
HOMEPAGE="http://yozvox.web.fc2.com/"
SRC_URI="http://yozvox.web.fc2.com/${MY_P}.7z"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="binchecks mirror strip"

DEPEND="app-arch/p7zip"
RDEPEND=""
S="${WORKDIR}/${MY_PN}"

FONT_SUFFIX="ttc ttf"
FONT_S=${S}
#FONT_CONF=( "${FILESDIR}"/66-${PN}.conf )

DOCS="Readme.txt Readme_E.txt"

src_prepare() {
	for f in *.TTC; do
		mv $f ${f%.TTC}.ttc
	done
}
