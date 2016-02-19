# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

MY_PN="MoboMoga"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Japanese TrueType fonts based on mplus-fonts and ja-ipafonts."
HOMEPAGE="http://yozvox.web.fc2.com/"
SRC_URI="http://yozvox.web.fc2.com/${MY_P}.7z"

# IPAfont license because IPAfont is stricter than mplus-fonts
# FYI: http://d.hatena.ne.jp/itouhiro/20120607
LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/p7zip
	app-i18n/nkf"
RDEPEND=""

S="${WORKDIR}/${MY_PN}"
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttc"
FONT_S=${S}

DOCS="Readme_MoboMogaGM.txt"

src_prepare(){
	nkf -S -w --overwrite Readme_MoboMogaGM.txt
}
