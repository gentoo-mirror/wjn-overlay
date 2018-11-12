# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

DESCRIPTION="Japanse fonts mixed mplus, IPA-font and also DejaVu, Bitter or Droid."
HOMEPAGE="http://mix-mplus-ipa.osdn.jp/migu/"
SRC_URI="
	mirror://osdn/mix-mplus-ipa/circle-mplus-1c-${PV}.zip
	mirror://osdn/mix-mplus-ipa/circle-mplus-2p-${PV}.zip
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/scripts/migu.pe?view=co -> migu.pe
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/scripts/merge_dejavu_sans?view=co -> merge_dejavu_sans
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/scripts/merge_bitter?view=co -> merge_bitter
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/scripts/merge_droid_sans?view=co -> merge_droid_sans
	http://osdn.jp/cvs/view/mplus-fonts/mplus_outline_fonts/scripts/set_instructions?view=co -> set_instructions
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/sfd.d/IPAGothic-regular.sfd.xz?view=co -> IPAGothic-regular.sfd.xz
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/sfd.d/IPAGothic-bold.sfd.xz?view=co -> IPAGothic-bold.sfd.xz
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/sfd.d/DejaVuSansCondensed-regular.sfd.xz?view=co -> DejaVuSansCondensed-regular.sfd.xz
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/sfd.d/DejaVuSansCondensed-bold.sfd.xz?view=co -> DejaVuSansCondensed-bold.sfd.xz
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/sfd.d/Bitr-regular.sfd.xz?view=co -> Bitr-regular.sfd.xz
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/sfd.d/Bitr-bold.sfd.xz?view=co -> Bitr-bold.sfd.xz
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/sfd.d/DroidSans-regular.sfd.xz?view=co -> DroidSans-regular.sfd.xz
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/sfd.d/DroidSans-bold.sfd.xz?view=co -> DroidSans-bold.sfd.xz
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/release/migu-1vs-README.txt?view=co -> migu-1vs-README.txt
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/release/migu-1bt-README.txt?view=co -> migu-1bt-README.txt
	http://osdn.jp/cvs/view/mix-mplus-ipa/mixfont-mplus-ipa/mplus_outline_fonts/mig.d/release/migu-2ds-README.txt?view=co -> migu-2ds-README.txt
	"

# IPAfont license because IPAfont is stricter than mplus-fonts
# FYI: http://d.hatena.ne.jp/itouhiro/20120607
LICENSE="IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="media-gfx/fontforge
		app-arch/unzip
		app-arch/xz-utils"
RDEPEND=""

S="${WORKDIR}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

RESTRICT="binchecks bindist mirror strip"

src_prepare() {
	cp "${DISTDIR}/migu.pe" "${S}"
	cp "${DISTDIR}"/merge* "${S}"
	cp "${DISTDIR}/set_instructions" "${S}"

	cp "${S}"/circle-mplus-*-${PV}/*.${FONT_SUFFIX} "${S}"

	mkdir -p mig.d/sfd.d
	mv *.sfd mig.d/sfd.d
}

src_compile() {
	fontforge -script migu.pe 1VS regular || die
	fontforge -script migu.pe 1VS bold	|| die
	fontforge -script migu.pe 1BT regular || die
	fontforge -script migu.pe 1BT bold	|| die
	fontforge -script migu.pe 2DS regular || die
	fontforge -script migu.pe 2DS bold	|| die
}

src_install() {
	rm circle*.ttf
	font_src_install
	dodoc "${DISTDIR}"/migu-*-README.txt
}
