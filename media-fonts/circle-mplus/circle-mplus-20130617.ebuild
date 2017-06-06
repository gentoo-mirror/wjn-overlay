# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

DESCRIPTION="Japanese TrueType fonts based on mplus-fonts."
HOMEPAGE="http://mix-mplus-ipa.osdn.jp/"
SRC_URI="
		mirror://osdn/mix-mplus-ipa/59023/${PN}-1c-${PV}.zip
		mirror://osdn/mix-mplus-ipa/59023/${PN}-1m-${PV}.zip
		mirror://osdn/mix-mplus-ipa/59023/${PN}-1p-${PV}.zip
		mirror://osdn/mix-mplus-ipa/59023/${PN}-2m-${PV}.zip
		mirror://osdn/mix-mplus-ipa/59023/${PN}-2p-${PV}.zip
"

LICENSE="mplus-fonts"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_prepare() {
	mv "${S}"/*/*.${FONT_SUFFIX} "${S}"
}