# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

MY_PN=${PN/-/}
MY_P="${MY_PN}_v_${PV//./_}"
S_DIR="61995"

DESCRIPTION="Japanese hand-written TTF includes much more kanji chars"
HOMEPAGE="http://nonty.net/sorry/"
SRC_URI="mirror://osdn/${MY_PN}/${S_DIR}/${MY_P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip
	app-i18n/nkf"
RDEPEND=""

S="${WORKDIR}/${MY_PN}"
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

DOCS="readme.txt"

src_prepare() {
	for fn in *.txt; do
		cp $fn ${fn%.txt}
		nkf -S -w ${fn%.txt} > $fn
	done
}
