# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

MY_PN="HZMaruGothic"

DESCRIPTION="HZMaruGothic is a Japanese rounded gothic font based on GlyphWiki"
HOMEPAGE="http://www.mars.dti.ne.jp/glyph/fonts.html"
SRC_URI="http://www.mars.dti.ne.jp/glyph/${MY_PN}.zip"

LICENSE="|| ( OFL-1.1 hanazono-font )"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}
