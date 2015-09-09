# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

DESCRIPTION="Japanese TrueType fonts based on mplus-fonts."
HOMEPAGE="http://mix-mplus-ipa.sourceforge.jp/"
SRC_URI="
		mirror://sourceforge.jp/mix-mplus-ipa/59023/${PN}-1c-${PV}.zip
		mirror://sourceforge.jp/mix-mplus-ipa/59023/${PN}-1m-${PV}.zip
		mirror://sourceforge.jp/mix-mplus-ipa/59023/${PN}-1p-${PV}.zip
		mirror://sourceforge.jp/mix-mplus-ipa/59023/${PN}-2m-${PV}.zip
		mirror://sourceforge.jp/mix-mplus-ipa/59023/${PN}-2p-${PV}.zip
"

LICENSE="mplus-fonts"
SLOT="0"
KEYWORDS=""
IUSE=""

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DEPEND="app-arch/unzip"
RDEPEND=""

src_prepare() {
	mv "${S}"/*/*.${FONT_SUFFIX} "${S}"
}
