# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit font

MY_PN=${PN%-font}
GOTHIC_VER="20080629"
MINCHO_VER="20080511"
MONAGO_VER="20080629"
MONO_VER="20080629"

DESCRIPTION="Togoshi-font is a font family based on Kochi-alternative"
HOMEPAGE="http://togoshi-font.osdn.jp/"
SRC_URI="
	mirror://osdn/${PN}/31792/${MY_PN}-gothic-${GOTHIC_VER}.tar.gz
	mirror://osdn/${PN}/30983/${MY_PN}-mincho-${MINCHO_VER}.tar.gz
	mirror://osdn/${PN}/31795/${MY_PN}-monago-${MONAGO_VER}.tar.gz
	mirror://osdn/${PN}/31796/${MY_PN}-mono-${MONO_VER}.tar.gz"

LICENSE="BSD wadalab-font"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_prepare() {
	for dn in *; do
		mv $dn/*.ttf ./
	done
}

src_install() {
	font_src_install
	for fn in */readme.html; do
		newdoc $fn $(dirname $fn | sed -e 's/-[0-9]\{8,\}//').html
	done
}
