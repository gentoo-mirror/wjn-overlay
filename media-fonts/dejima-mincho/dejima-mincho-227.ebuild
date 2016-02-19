# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

MY_PN=${PN/mincho/fonts}

DESCRIPTION="Japanese TrueType mincho font derived from Tsukiji Mincho"
HOMEPAGE="https://code.google.com/p/dejima-fonts/"
SRC_URI="
	https://${MY_PN}.googlecode.com/files/${PN}-r${PV}.ttf -> ${PN}-r${PV}.ttf
	https://${MY_PN}.googlecode.com/hg/README -> ${PN}-README"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

S=${DISTDIR}
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

DOCS="${PN}-README"
