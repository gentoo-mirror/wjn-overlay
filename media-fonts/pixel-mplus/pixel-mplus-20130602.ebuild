# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit font

MY_P="PixelMplus-${PV}"

DESCRIPTION="Japanese TrueType monospace fonts looks like bitmap fonts, based on mplus-fonts."
HOMEPAGE="http://mix-mplus-ipa.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/mix-mplus-ipa/58930/${MY_P}.zip"
	
LICENSE="mplus-fonts"
SLOT="0"
KEYWORDS=""
IUSE=""

S="${WORKDIR}/${MY_P}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DEPEND="app-arch/unzip"
RDEPEND=""

