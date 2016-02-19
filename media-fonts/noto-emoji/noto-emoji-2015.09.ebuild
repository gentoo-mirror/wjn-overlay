# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

MY_PN="NotoEmoji"
MY_PV="v2015-09-29-license-apache"
GITHUB_URI="https://raw.githubusercontent.com/googlei18n/noto-emoji/${MY_PV}"
DESCRIPTION="Color and Black-and-White Noto Emoji fonts by Google"
HOMEPAGE="http://www.google.com/get/noto/
	https://github.com/googlei18n/noto-emoji"
SRC_URI="
	${GITHUB_URI}/NotoEmoji-Regular.ttf -> ${P}-Regular.ttf
	${GITHUB_URI}/AUTHORS				-> ${P}-AUTHORS
	${GITHUB_URI}/CONTRIBUTING.md		-> ${P}-CONTRIBUTING.md
	${GITHUB_URI}/CONTRIBUTORS			-> ${P}-CONTRIBUTORS
	${GITHUB_URI}/README.md				-> ${P}-README.md
"

# NOTE: License is still Apache-2.0, changed OFL-1.1 after this version
# https://github.com/googlei18n/noto-emoji/releases/tag/v2015-09-29-license-apache
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# As of 2015.04, media-fonts/noto doesn't include this fonts
# DEPEND="!!>=media-fonts/noto-2015.05"
DEPEND=""
RDEPEND=""

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

DOCS="AUTHORS CONTRIBUTING.md CONTRIBUTORS README.md"

FONT_SUFFIX="ttf"
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
