# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit font

MY_P="07Yasashisa"

DESCRIPTION="Japanese OpenType serif sans-serif mixed font"
HOMEPAGE="http://www.fontna.com/blog/1122/"
SRC_URI="http://flop.sakura.ne.jp/font/fontna-op/${MY_P}.zip"

# IPAfont license because IPAfont is stricter than mplus-fonts
# FYI: http://d.hatena.ne.jp/itouhiro/20120607
LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip
	app-i18n/nkf
	app-text/convmv"
RDEPEND=""

S="${WORKDIR}/${MY_P}"
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DOCS="ReadMe_unix.txt"

src_prepare() {
	convmv -f Shift_JIS -t UTF-8 --notest *.ttf
	mv "07やさしさゴシック.ttf" "07YasashisaGothic.ttf"
	nkf -w --overwrite ReadMe_unix.txt
}
