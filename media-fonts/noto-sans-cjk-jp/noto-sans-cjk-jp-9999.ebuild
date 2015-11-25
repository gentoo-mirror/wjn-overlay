# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

DESCRIPTION="a Japanese OpenType font family by Google"
HOMEPAGE="http://www.google.com/get/noto/cjk.html
	https://github.com/googlei18n/noto-cjk"
SRC_URI="
	http://www.google.com/get/noto/pkgs/NotoSansCJKJP-hinted.zip
		-> ${P}.zip
	https://github.com/googlei18n/noto-cjk/raw/master/HISTORY
		-> ${P}-HISTORY
	https://github.com/googlei18n/noto-cjk/raw/master/NEWS
		-> ${P}-NEWS
	https://github.com/googlei18n/noto-cjk/raw/master/README.formats
		-> ${P}-README.formats
	https://github.com/googlei18n/noto-cjk/raw/master/README.third_party
		-> ${P}-README.third_party
	"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""
RESTRICT="binchecks mirror strip"

DEPEND="app-arch/unzip"
RDEPEND=""
S=${WORKDIR}

DOCS="HISTORY NEWS README.formats README.third_party"

FONT_SUFFIX="otf"
FONT_S=${S}

src_unpack() {
	unpack ${P}.zip
	for fn in ${DOCS[@]}; do
		cp "${DISTDIR}/${P}-${fn}" "${S}/${fn}"
	done
}
