# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
VALA_MIN_API_VERSION="0.24"

inherit autotools python-single-r1 vala

DESCRIPTION="Japanese Kana Kanji conversion library"
HOMEPAGE="https://github.com/ueno/libkkc
	https://bitbucket.org/libkkc/libkkc"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ueno/libkkc.git"
	EGIT_BRANCH="master"
else
	SRC_URI="https://github.com/ueno/${PN}/releases/download/v${PV}/${P}.tar.gz"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="doc introspection +nls static-libs"

COMMON_DEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.24:2
	>=dev-libs/json-glib-1.0
	dev-libs/libgee:0.8
	dev-libs/marisa[python,${PYTHON_USEDEP}]"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	virtual/pkgconfig
	introspection? ( >=dev-libs/gobject-introspection-0.9.0 )
	nls? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEPEND}"
PDEPEND="app-i18n/libkkc-data
	app-i18n/skk-jisyo"

RESTRICT="mirror"

DOCS=( README.md )

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	eautoreconf
	vala_src_prepare
}

src_configure(){
	econf  $(use_enable doc docs) \
		 $(use_enable nls) \
		 $(use_enable introspection) \
		 $(use_enable static-libs static)
}
