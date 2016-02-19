# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

MY_P="Koruri-${PV}"
OSDN_DIR="63935"

DESCRIPTION="Japanese TrueType font obtained by mixing M+ FONTS and Open Sans"
HOMEPAGE="http://koruri.lindwurm.biz/"
SRC_URI="mirror://osdn/koruri/${OSDN_DIR}/${MY_P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"
RESTRICT="binchecks mirror strip"

DOCS="README.md README_E.mplus README_J.mplus README_ja.md"

FONT_SUFFIX="ttf"
FONT_S=${S}
