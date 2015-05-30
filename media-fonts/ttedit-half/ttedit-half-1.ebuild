# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit font

MY_PN="halffont"
MY_P="${MY_PN}${PV}"

DESCRIPTION="Japanese TrueType half-width mincho and gothic fonts based on IPA fonts."
HOMEPAGE="http://opentype.jp/hankakufont.htm"
SRC_URI="http://opentype.jp/bin/${MY_PN}.zip"

LICENSE="IPAfont"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="binchecks strip"

DEPEND="app-arch/unzip"
RDEPEND=""
S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DOCS="Readme.txt"

