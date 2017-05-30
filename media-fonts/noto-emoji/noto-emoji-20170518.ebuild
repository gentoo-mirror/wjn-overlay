# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit font

MY_PN="NotoEmoji"
MY_PV="v2017-05-18-cook-color-fix"
GITHUB_URI="https://raw.githubusercontent.com/googlei18n/noto-emoji/${MY_PV}"

DESCRIPTION="Color and Black-and-White Noto Emoji fonts by Google"
HOMEPAGE="http://www.google.com/get/noto/
	https://github.com/googlei18n/noto-emoji"
SRC_URI="
	${GITHUB_URI}/fonts/NotoColorEmoji.ttf		-> ${P}-Color.ttf
	${GITHUB_URI}/fonts/NotoEmoji-Regular.ttf	-> ${P}-Regular.ttf
	${GITHUB_URI}/AUTHORS						-> ${P}-AUTHORS
	${GITHUB_URI}/CONTRIBUTING.md				-> ${P}-CONTRIBUTING.md
	${GITHUB_URI}/CONTRIBUTORS					-> ${P}-CONTRIBUTORS
	${GITHUB_URI}/README.md						-> ${P}-README.md
"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
