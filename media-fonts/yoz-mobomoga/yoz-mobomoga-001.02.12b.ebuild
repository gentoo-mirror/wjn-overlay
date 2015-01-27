# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit font

MY_PN="MoboMoga"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Japanese TrueType fonts based on mplus-fonts and ja-ipafonts."
HOMEPAGE="http://yozvox.web.fc2.com/"
SRC_URI="http://yozvox.web.fc2.com/${MY_P}.7z"

LICENSE="IPAfont"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="binchecks strip"

DEPEND="app-arch/p7zip"
RDEPEND=""
S="${WORKDIR}/${MY_PN}"

FONT_SUFFIX="ttc"
FONT_S="${S}"
#FONT_CONF=( "${FILESDIR}"/66-${PN}.conf )

DOCS="Readme_MoboMogaGM.txt"

