# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

MY_P="PixelMplus-${PV}"

DESCRIPTION="Japanese TrueType monospace fonts looks like bitmap fonts, based on mplus-fonts."
HOMEPAGE="http://mix-mplus-ipa.osdn.jp/"
SRC_URI="mirror://osdn/mix-mplus-ipa/58930/${MY_P}.zip"

LICENSE="mplus-fonts"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${MY_P}"
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S="${S}"