# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

MY_PN=${PN/mincho/fonts}

DESCRIPTION="Japanese TrueType mincho font derived from Tsukiji Mincho"
HOMEPAGE="https://code.google.com/p/dejima-fonts/"

# TBD: Since googlecode was closed, Archiving or deleting this pkg is required
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/${MY_PN}/${PN}-r${PV}.ttf -> ${PN}-r${PV}.ttf"
#	https://${MY_PN}.googlecode.com/hg/README -> ${PN}-README

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
