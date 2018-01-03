# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit font

DESCRIPTION="Japanese OpenType brush font written by AOYAGI Kohzan."
HOMEPAGE="http://opentype.jp/freemouhitufont.htm"
SRC_URI="http://opentype.jp/bin/KouzanMouhituFontOTF.zip
	http://opentype.jp/bin/AoyagiKouzanTOTF.zip
	http://opentype.jp/bin/KouzanGyoushoOTF.zip
	http://opentype.jp/bin/KouzanSoushoOTF.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="binchecks mirror strip"

DEPEND="app-arch/unzip"
RDEPEND=""
S=${WORKDIR}

FONT_SUFFIX="otf"
FONT_S=${S}

DOCS=""
