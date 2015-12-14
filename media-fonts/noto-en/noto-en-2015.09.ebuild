# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

MY_PV="v2015-09-29-license-adobe"
GITHUB_URI="https://raw.githubusercontent.com/googlei18n/noto-fonts/${MY_PV}"
DESCRIPTION="Only English fonts package from Noto Fonts by Google"
HOMEPAGE="http://www.google.com/get/noto/
	https://github.com/googlei18n/noto-fonts"
SRC_URI="!unhinted? ( ${GITHUB_URI}/hinted/NotoSans-Bold.ttf
	${GITHUB_URI}/hinted/NotoSans-BoldItalic.ttf
	${GITHUB_URI}/hinted/NotoSans-Italic.ttf
	${GITHUB_URI}/hinted/NotoSans-Regular.ttf
	${GITHUB_URI}/hinted/NotoSansUI-Bold.ttf
	${GITHUB_URI}/hinted/NotoSansUI-BoldItalic.ttf
	${GITHUB_URI}/hinted/NotoSansUI-Italic.ttf
	${GITHUB_URI}/hinted/NotoSansUI-Regular.ttf
	${GITHUB_URI}/hinted/NotoSerif-Bold.ttf
	${GITHUB_URI}/hinted/NotoSerif-BoldItalic.ttf
	${GITHUB_URI}/hinted/NotoSerif-Italic.ttf
	${GITHUB_URI}/hinted/NotoSerif-Regular.ttf )
	unhinted? ( ${GITHUB_URI}/unhinted/NotoSans-Bold.ttf
	${GITHUB_URI}/unhinted/NotoSans-BoldItalic.ttf
	${GITHUB_URI}/unhinted/NotoSans-Italic.ttf
	${GITHUB_URI}/unhinted/NotoSans-Regular.ttf
	${GITHUB_URI}/unhinted/NotoSansUI-Bold.ttf
	${GITHUB_URI}/unhinted/NotoSansUI-BoldItalic.ttf
	${GITHUB_URI}/unhinted/NotoSansUI-Italic.ttf
	${GITHUB_URI}/unhinted/NotoSansUI-Regular.ttf
	${GITHUB_URI}/unhinted/NotoSerif-Bold.ttf
	${GITHUB_URI}/unhinted/NotoSerif-BoldItalic.ttf
	${GITHUB_URI}/unhinted/NotoSerif-Italic.ttf
	${GITHUB_URI}/unhinted/NotoSerif-Regular.ttf )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="-unhinted"

DEPEND="!!media-fonts/noto"
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_unpack() {
	cp "${DISTDIR}"/*.ttf "${S}"
}
