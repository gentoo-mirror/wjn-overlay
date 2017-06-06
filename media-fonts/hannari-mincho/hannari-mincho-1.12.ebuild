# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

MY_PN="${PN%-mincho}"

DESCRIPTION="a Japanese mincho OpenType font with IPAmincho kanji chars"
HOMEPAGE="http://typingart.net/?p=44"
SRC_URI="http://typingart.net/fontdata/${MY_PN}.zip"

LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip
	app-i18n/nkf"
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks fetch mirror strip"

FONT_SUFFIX="otf"
FONT_S=${S}

DOCS="read_me.txt"

pkg_nofetch() {
	einfo " This author forbids downloading directly."
	einfo " Please visit ${HOMEPAGE}"
	einfo "download ${MY_PN}.zip"
	einfo "and place them in ${DISTDIR}"
}

src_prepare() {
	for fn in *.txt; do
		cp $fn ${fn%.txt}
		nkf -S -w ${fn%.txt} > $fn
	done
}
