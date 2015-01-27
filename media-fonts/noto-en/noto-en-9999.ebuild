# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit font

DESCRIPTION="Noto Fonts serif, sans and UI. an English font family by Google"
HOMEPAGE="http://www.google.com/get/noto/"
SRC_URI="
	http://www.google.com/get/noto/pkgs/NotoSans-hinted.zip
	http://www.google.com/get/noto/pkgs/NotoSerif-hinted.zip
	https://noto.googlecode.com/git/fonts/individual/hinted/NotoSansUI-Regular.ttf
	https://noto.googlecode.com/git/fonts/individual/hinted/NotoSansUI-Italic.ttf
	https://noto.googlecode.com/git/fonts/individual/hinted/NotoSansUI-Bold.ttf
	https://noto.googlecode.com/git/fonts/individual/hinted/NotoSansUI-BoldItalic.ttf
	"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="binchecks strip"

DEPEND="app-arch/unzip"
RDEPEND=""
S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

src_unpack() {
	unpack NotoSans-hinted.zip NotoSerif-hinted.zip
	cp "${DISTDIR}"/*.ttf "${S}"
}

