# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

MY_PN="NotoSansCJKjp"
MY_PV="v${PV}"
GITHUB_URI="https://raw.githubusercontent.com/googlei18n/noto-cjk/${MY_PV}"
DESCRIPTION="a Japanese OpenType font family by Google"
HOMEPAGE="http://www.google.com/get/noto/cjk.html
	https://github.com/googlei18n/noto-cjk"
SRC_URI="${GITHUB_URI}/NotoSansCJKjp-Black.otf	-> ${P}-Black.otf
	${GITHUB_URI}/NotoSansCJKjp-Bold.otf		-> ${P}-Bold.otf
	${GITHUB_URI}/NotoSansCJKjp-DemiLight.otf	-> ${P}-DemiLight.otf
	${GITHUB_URI}/NotoSansCJKjp-Light.otf		-> ${P}-Light.otf
	${GITHUB_URI}/NotoSansCJKjp-Medium.otf		-> ${P}-Medium.otf
	${GITHUB_URI}/NotoSansCJKjp-Regular.otf		-> ${P}-Regular.otf
	${GITHUB_URI}/NotoSansCJKjp-Thin.otf		-> ${P}-Thin.otf
	${GITHUB_URI}/HISTORY						-> ${P}-HISTORY
	${GITHUB_URI}/NEWS							-> ${P}-NEWS
	${GITHUB_URI}/README.formats				-> ${P}-README.formats
	${GITHUB_URI}/README.third_party			-> ${P}-README.third_party"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

DOCS="HISTORY NEWS README.formats README.third_party"

FONT_SUFFIX="otf"
FONT_S=${S}

src_unpack() {
	local fontfile newname docfile

	for fontfile in "${DISTDIR}"/*."${FONT_SUFFIX}" ; do
		newname=$(basename "${fontfile}")
		newname=${newname/"${P}"/"${MY_PN}"}
		cp "${fontfile}" "${FONT_S}/${newname}"
	done

	for docfile in ${DOCS[@]} ; do
		cp "${DISTDIR}/${P}-${docfile}" "${S}/${docfile}"
	done
}
