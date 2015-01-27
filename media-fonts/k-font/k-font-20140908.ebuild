# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit font

DESCRIPTION="'K-Font!', Japanese TrueType font like TV anime 'K-ON!'"
HOMEPAGE="http://font.sumomo.ne.jp/index.html"
SRC_URI="http://font.sumomo.ne.jp/fontdata/k-font.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="binchecks strip"

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DEPEND="app-arch/unzip"
RDEPEND=""

