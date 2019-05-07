# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Supporting Python 3 is still in progress
# PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )
PYTHON_COMPAT=( python2_7 )

DISTUTILS_IN_SOURCE_BUILD=1

inherit desktop distutils-r1 toolchain-funcs xdg-utils

DESCRIPTION="Visual novel engine written in python"
HOMEPAGE="https://www.renpy.org/"
SRC_URI="https://www.renpy.org/dl/${PV}/${P}-source.tar.bz2"

LICENSE="MIT"
SLOT="$(ver_cut 1-2)"
MYSLOT=$(ver_rs 1- '' ${SLOT})
KEYWORDS="~amd64 ~x86"
IUSE="development doc examples"
REQUIRED_USE="examples? ( development )"

COMMON_DEPEND=">=app-eselect/eselect-renpy-0.8
	~dev-python/pygame_sdl2-${PV}[${PYTHON_USEDEP}]
	>=dev-lang/python-exec-0.3[${PYTHON_USEDEP}]
	media-libs/glew:0
	media-libs/libpng:0
	media-libs/libsdl2[video]
	media-libs/freetype:2
	sys-libs/zlib
	virtual/ffmpeg"
DEPEND="${COMMON_DEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	virtual/pkgconfig"
RDEPEND=${COMMON_DEPEND}

S=${WORKDIR}/${P}-source
RESTRICT="mirror"

PATCHES=( "${FILESDIR}"/${PN}-6.99.14.3-multiple-abi.patch
	"${FILESDIR}"/${PN}-6.99.14.3-compat-style.patch
	"${FILESDIR}"/${PN}-6.99.14.3-compat-infinite-loop.patch
	"${FILESDIR}"/${PN}-6.99.14.3-not-choose-new-tutorial.patch )

pkg_setup() {
	export EPYTHON="python2.7"
}

python_prepare_all() {
#	export CFLAGS="${CFLAGS} $($(tc-getPKG_CONFIG) --cflags fribidi)"
	distutils-r1_python_prepare_all

	einfo "Deleting precompiled python files"
	find . -name '*.py[co]' -print -delete || die

	python_fix_shebang "${S}"

	sed -i \
		-e "s/@SLOT@/${MYSLOT}/" \
		renpy.py renpy/common.py || die "setting slot failed!"

}

python_compile() {
	cd "${S}"/module || die
	distutils-r1_python_compile
}

python_install() {
	cd "${S}"/module || die
	distutils-r1_python_install --install-lib="$(python_get_sitedir)/renpy${MYSLOT}"

	cd "${S}" || die
	python_newscript renpy.py ${PN}-${SLOT}

	python_moduleinto renpy${MYSLOT}
	python_domodule gui renpy
	if use development ; then
		python_domodule atom launcher
	fi
	if use examples ; then
		python_domodule the_question tutorial
	fi
}

python_install_all() {
	distutils-r1_python_install_all
	if use development; then
		newicon -s 32 launcher/game/images/logo32.png ${P}.png
		make_desktop_entry ${PN}-${SLOT} "Ren'Py ${PV}" ${P}
	fi

	if use doc; then
		insinto "/usr/share/doc/${PF}/html"
		doins -r doc/*
	fi
	newman "${FILESDIR}/${PN}.1" "${P}.1"
}

pkg_postinst() {
	use development && xdg_icon_cache_update

	einfo "running: eselect renpy update --if-unset"
	eselect renpy update --if-unset
}

pkg_postrm() {
	use development && xdg_icon_cache_update

	einfo "running: eselect renpy update --if-unset"
	eselect renpy update --if-unset
}