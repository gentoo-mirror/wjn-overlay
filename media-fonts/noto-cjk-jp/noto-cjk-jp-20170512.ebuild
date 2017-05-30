# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit font

MY_PN="NotoCJKjp"
MY_PV="9beb8b833bf5eeaf3d89f019ff0618931127a47f"
GITHUB_URI="https://raw.githubusercontent.com/googlei18n/noto-cjk/${MY_PV}"

DESCRIPTION="a Japanese OpenType font family by Google"
HOMEPAGE="http://www.google.com/get/noto/cjk.html
	https://github.com/googlei18n/noto-cjk"
SRC_URI="
	${GITHUB_URI}/NotoSansCJKjp-Black.otf		-> ${P}-Sans-Black.otf
	${GITHUB_URI}/NotoSansCJKjp-Bold.otf		-> ${P}-Sans-Bold.otf
	${GITHUB_URI}/NotoSansCJKjp-DemiLight.otf	-> ${P}-Sans-DemiLight.otf
	${GITHUB_URI}/NotoSansCJKjp-Light.otf		-> ${P}-Sans-Light.otf
	${GITHUB_URI}/NotoSansCJKjp-Medium.otf		-> ${P}-Sans-Medium.otf
	${GITHUB_URI}/NotoSansCJKjp-Regular.otf		-> ${P}-Sans-Regular.otf
	${GITHUB_URI}/NotoSansCJKjp-Thin.otf		-> ${P}-Sans-Thin.otf
	${GITHUB_URI}/NotoSansMonoCJKjp-Bold.otf	-> ${P}-Mono-Bold.otf
	${GITHUB_URI}/NotoSansMonoCJKjp-Regular.otf	-> ${P}-Mono-Regular.otf
	${GITHUB_URI}/NotoSerifCJKjp-Black.otf		-> ${P}-Serif-Black.otf
	${GITHUB_URI}/NotoSerifCJKjp-Bold.otf		-> ${P}-Serif-Bold.otf
	${GITHUB_URI}/NotoSerifCJKjp-ExtraLight.otf	-> ${P}-Serif-DemiLight.otf
	${GITHUB_URI}/NotoSerifCJKjp-Light.otf		-> ${P}-Serif-Light.otf
	${GITHUB_URI}/NotoSerifCJKjp-Medium.otf		-> ${P}-Serif-Medium.otf
	${GITHUB_URI}/NotoSerifCJKjp-Regular.otf	-> ${P}-Serif-Regular.otf
	${GITHUB_URI}/NotoSerifCJKjp-SemiBold.otf	-> ${P}-Serif-Thin.otf
	${GITHUB_URI}/HISTORY						-> ${P}-HISTORY
	${GITHUB_URI}/NEWS							-> ${P}-NEWS
	${GITHUB_URI}/README.formats				-> ${P}-README.formats
	${GITHUB_URI}/README.third_party			-> ${P}-README.third_party"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="!!media-fonts/noto[cjk]
	!!media-fonts/noto-cjk
	!!media-fonts/noto-sans-cjk-jp"
RDEPEND=${DEPEND}

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
