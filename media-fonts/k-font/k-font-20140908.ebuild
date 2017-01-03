# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

DESCRIPTION="'K-Font!', Japanese TrueType font like TV anime 'K-ON!'"
HOMEPAGE="http://font.sumomo.ne.jp/index.html"
SRC_URI="http://font.sumomo.ne.jp/fontdata/k-font.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="binchecks mirror strip"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DEPEND="app-arch/unzip"
RDEPEND=""

src_prepare(){
	rm *"Apache License 2.0.txt"
	nkf -S -w *.txt > README
}

src_install(){
	font_src_install
	dodoc README
	docinto mplus-TESTFLIGHT-058
	dodoc mplus-TESTFLIGHT-058/README*
}
