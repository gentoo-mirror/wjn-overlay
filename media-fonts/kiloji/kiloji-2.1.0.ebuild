# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

DESCRIPTION="A Japanese hand-written TrueType font family"
HOMEPAGE="http://www.ez0.net/distribution/font/kiloji/"
SRC_URI="
	http://www.ez0.net/wp-content/uploads/distribution/font/${PN}/${P/-/_}.zip
	http://www.ez0.net/wp-content/uploads/distribution/font/${PN}/${P/-/_p}.zip
	http://www.ez0.net/wp-content/uploads/distribution/font/${PN}/${P/-/_d}.zip
	http://www.ez0.net/wp-content/uploads/distribution/font/${PN}/${P/-/_b}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}
