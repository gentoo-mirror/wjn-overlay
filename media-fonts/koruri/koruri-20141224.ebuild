# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

MY_P="Koruri-${PV}"

DESCRIPTION="Japanese TrueType font obtained by mixing M+ FONTS and Open Sans"
HOMEPAGE="http://koruri.lindwurm.biz/"
SRC_URI="mirror://sourceforge.jp/koruri/62469/${MY_P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="binchecks strip"

DEPEND=""
RDEPEND=""
S="${WORKDIR}/${MY_P}"

DOCS=( README.md README_ja.md )

FONT_SUFFIX="ttf"
FONT_S="${S}"

