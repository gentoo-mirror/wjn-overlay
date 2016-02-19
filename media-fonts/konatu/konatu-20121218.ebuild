# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

MY_P="Konatu_ver_${PV}"

DESCRIPTION="Japanese TrueType sans-serif font made for BeOS"
HOMEPAGE="http://www.masuseki.com/?u=be/konatu.htm"
SRC_URI="http://www.masuseki.com/be/${PN}/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="binchecks mirror strip"

S="${WORKDIR}/${MY_P}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DEPEND="app-arch/unzip"
RDEPEND=""

DOCS="README.txt README_Japanese.txt"
