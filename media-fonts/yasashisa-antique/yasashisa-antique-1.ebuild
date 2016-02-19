# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

MY_P="YasashisaAntiqueFont"

DESCRIPTION="Japanese OpenType serif sans-serif mixed font"
HOMEPAGE="http://www.fontna.com/blog/1122/"
SRC_URI="http://flop.sakura.ne.jp/font/fontna-op/${MY_P}.zip"

# IPAfont license because IPAfont is stricter than mplus-fonts
# FYI: http://d.hatena.ne.jp/itouhiro/20120607
LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${MY_P}"
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="otf"
FONT_S="${S}"

DOCS="ReadMe_unix.txt"

src_prepare() {
	nkf -w --overwrite ReadMe_unix.txt
}
