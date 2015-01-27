# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit font

MY_PN="AoyagiSosekiFontOTF"
MY_P="${MY_PN}${PV}"

DESCRIPTION="Japanese OpenType brush font written by AOYAGI Soseki."
HOMEPAGE="http://opentype.jp/aoyagisosekifont.htm"
SRC_URI="http://opentype.jp/bin/${MY_PN}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="binchecks strip"

DEPEND="app-arch/unzip"
RDEPEND=""
S="${WORKDIR}"

FONT_SUFFIX="otf"
FONT_S="${S}"

DOCS=""

