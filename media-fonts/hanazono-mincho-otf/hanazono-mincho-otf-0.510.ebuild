# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

MY_PN="HanaMinOT"
S_DIR="55143"

DESCRIPTION="HanaMinOT is a Japanese mincho OpenType font based on GryphWiki"
HOMEPAGE="http://shiromoji.net/font/HanaMinOT/"
SRC_URI="mirror://sourceforge.jp/${MY_PN,,}/${S_DIR}/${MY_PN}-${PV}.zip"

LICENSE="|| ( OFL-1.1 hanazono-font )"
SLOT="0"
KEYWORDS=""

DEPEND="app-arch/unzip
	>=app-shells/bash-4"
RDEPEND=""

S="${WORKDIR}/${MY_PN}-${PV}"
RESTRICT="binchecks strip"

FONT_SUFFIX="otf"
FONT_S=${S}

DOCS=("readme.txt")
