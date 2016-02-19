# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

MY_PN=${PN%-mincho}
S_DIR="62072"

DESCRIPTION="Hanazono font is a Japanese mincho font based on GlyphWiki"
HOMEPAGE="http://fonts.jp/hanazono/"
SRC_URI="mirror://osdn/${MY_PN}-font/${S_DIR}/${MY_PN}-${PV}.zip"

LICENSE="|| ( OFL-1.1 hanazono-font )"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

DOCS="THANKS.txt README.txt"
