# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils flag-o-matic

DESCRIPTION="A software synthesizer based on ZynAddSubFX"
HOMEPAGE="http://yoshimi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+lv2"

RDEPEND="
	>=dev-libs/mini-xml-2.5
	>=media-libs/alsa-lib-1.0.17
	media-libs/fontconfig
	media-libs/libsndfile
	sci-libs/fftw:3.0
	sys-libs/ncurses:0=
	sys-libs/zlib
	virtual/jack
	x11-libs/cairo[X]
	x11-libs/fltk:1[opengl]
	lv2? ( media-libs/lv2 )
"
DEPEND="${RDEPEND}
	dev-libs/boost
	virtual/pkgconfig
"

RESTRICT="mirror"

PATCHES=( "${FILESDIR}/${PN}-1.4.1-underlinking.patch" )

CMAKE_USE_DIR="${WORKDIR}/${P}/src"

src_prepare() {
	mv Change{l,L}og || die
	sed -i \
		-e '/set (CMAKE_CXX_FLAGS_RELEASE/d' \
		-e "s:lib/lv2:$(get_libdir)/lv2:" \
		src/CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	append-ldflags -pthread
	local mycmakeargs=(
		-DBuildLV2Plugin=$(usex lv2)
	)
	cmake-utils_src_configure
}
