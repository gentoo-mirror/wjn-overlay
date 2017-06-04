# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

MY_PN="Noto"
MY_PV="1293ec36da617d4b730e8455ed80632ed1222834"
GITHUB_URI="https://raw.githubusercontent.com/googlei18n/noto-fonts/${MY_PV}"

DESCRIPTION="Only English fonts package from Noto Fonts by Google"
HOMEPAGE="http://www.google.com/get/noto/
	https://github.com/googlei18n/noto-fonts"
SRC_URI="!unhinted? (
		${GITHUB_URI}/hinted/NotoMono-Regular.ttf
			-> ${P}-Mono-Regular-hinted.ttf
		${GITHUB_URI}/hinted/NotoSans-Bold.ttf
			-> ${P}-Sans-Bold-hinted.ttf
		${GITHUB_URI}/hinted/NotoSans-BoldItalic.ttf
			-> ${P}-Sans-BoldItalic-hinted.ttf
		${GITHUB_URI}/hinted/NotoSans-Italic.ttf
			-> ${P}-Sans-Italic-hinted.ttf
		${GITHUB_URI}/hinted/NotoSans-Regular.ttf
			-> ${P}-Sans-Regular-hinted.ttf
		${GITHUB_URI}/hinted/NotoSansUI-Bold.ttf
			-> ${P}-SansUI-Bold-hinted.ttf
		${GITHUB_URI}/hinted/NotoSansUI-BoldItalic.ttf
			-> ${P}-SansUI-BoldItalic-hinted.ttf
		${GITHUB_URI}/hinted/NotoSansUI-Italic.ttf
			-> ${P}-SansUI-Italic-hinted.ttf
		${GITHUB_URI}/hinted/NotoSansUI-Regular.ttf
			-> ${P}-SansUI-Regular-hinted.ttf
		${GITHUB_URI}/hinted/NotoSerif-Bold.ttf
			-> ${P}-Serif-Bold-hinted.ttf
		${GITHUB_URI}/hinted/NotoSerif-BoldItalic.ttf
			-> ${P}-Serif-BoldItalic-hinted.ttf
		${GITHUB_URI}/hinted/NotoSerif-Italic.ttf
			-> ${P}-Serif-Italic-hinted.ttf
		${GITHUB_URI}/hinted/NotoSerif-Regular.ttf
			-> ${P}-Serif-Regular-hinted.ttf )
	unhinted? (	${GITHUB_URI}/unhinted/NotoSans-Bold.ttf
			-> ${P}-Sans-Bold-unhinted.ttf
		${GITHUB_URI}/unhinted/NotoSans-BoldItalic.ttf
			-> ${P}-Sans-BoldItalic-unhinted.ttf
		${GITHUB_URI}/unhinted/NotoSans-Italic.ttf
			-> ${P}-Sans-Italic-unhinted.ttf
		${GITHUB_URI}/unhinted/NotoSans-Regular.ttf
			-> ${P}-Sans-Regular-unhinted.ttf
		${GITHUB_URI}/unhinted/NotoSansUI-Bold.ttf
			-> ${P}-SansUI-Bold-unhinted.ttf
		${GITHUB_URI}/unhinted/NotoSansUI-BoldItalic.ttf
			-> ${P}-SansUI-BoldItalic-unhinted.ttf
		${GITHUB_URI}/unhinted/NotoSansUI-Italic.ttf
			-> ${P}-SansUI-Italic-unhinted.ttf
		${GITHUB_URI}/unhinted/NotoSansUI-Regular.ttf
			-> ${P}-SansUI-Regular-unhinted.ttf
		${GITHUB_URI}/unhinted/NotoSerif-Bold.ttf
			-> ${P}-Serif-Bold-unhinted.ttf
		${GITHUB_URI}/unhinted/NotoSerif-BoldItalic.ttf
			-> ${P}-Serif-BoldItalic-unhinted.ttf
		${GITHUB_URI}/unhinted/NotoSerif-Italic.ttf
			-> ${P}-Serif-Italic-unhinted.ttf
		${GITHUB_URI}/unhinted/NotoSerif-Regular.ttf
			-> ${P}-Serif-BoldItalic-unhinted.ttf )
	${GITHUB_URI}/FAQ.md			-> ${P}-FAQ.md
	${GITHUB_URI}/NEWS				-> ${P}-NEWS
	${GITHUB_URI}/README.md			-> ${P}-README.md
	${GITHUB_URI}/issue_template.md	-> ${P}-issue_template.md"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-unhinted"

# media-fonts/noto includes this fonts
DEPEND="!!media-fonts/noto"
RDEPEND=${DEPEND}

S=${WORKDIR}
RESTRICT="binchecks mirror strip"

DOCS="FAQ.md NEWS README.md issue_template.md"

FONT_SUFFIX="ttf"
FONT_S=${S}

src_unpack() {
	local fontfile newname docfile

	for fontfile in "${DISTDIR}"/*."${FONT_SUFFIX}" ; do
		newname=$(basename "${fontfile}")
		newname=${newname/"${P}-"/"${MY_PN}"}
		newname=${newname/-unhinted/}
		newname=${newname/-hinted/}
		cp "${fontfile}" "${FONT_S}/${newname}"
	done

	for docfile in ${DOCS[@]} ; do
		cp "${DISTDIR}/${P}-${docfile}" "${S}/${docfile}"
	done
}