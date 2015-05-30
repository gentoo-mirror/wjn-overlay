# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

DESCRIPTION="a Japanese font family by Google"
HOMEPAGE="http://www.google.com/get/noto/cjk.html"
SRC_URI="http://www.google.com/get/noto/pkgs/NotoSansCJKJP-hinted.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="binchecks strip"

DEPEND="app-arch/unzip"
RDEPEND=""
S="${WORKDIR}"

FONT_SUFFIX="otf"
FONT_S="${S}"

