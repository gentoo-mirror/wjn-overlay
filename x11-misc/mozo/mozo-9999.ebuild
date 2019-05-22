# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python3_{5,6,7} )
PYTHON_REQ_USE="xml"

inherit git-r3 meson multibuild python-r1

DESCRIPTION="Menu editor for MATE desktop using freedesktop.org menu spec"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=mate-base/mate-menus-1.21.0:0[introspection,python(+)]"
BDEPEND="${COMMON_DEPEND}
	sys-apps/sed:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}
	${PYTHON_DEPS}
	dev-libs/gobject-introspection
	x11-libs/gdk-pixbuf:2[introspection]
	x11-libs/gtk+:3[introspection]
	virtual/libintl:0"

DOCS=( AUTHORS ChangeLog NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	# Support build target to Python 3.{6,7}
	sed -i -e '/AM_PATH_PYTHON/s/(3.5)/(3.5, 3.6, 3.7)/' configure.ac || die

	# Fix python path to global one
	sed -i -e "s:py3.path():'/usr/bin/python':g" meson.build || die

	eapply_user
	python_copy_sources

	# Delete duplicated files for meson_src_configure
	python_foreach_impl run_in_build_dir rm meson.build
}

src_configure() {
	python_foreach_impl run_in_build_dir meson_src_configure
}

src_compile() {
	python_foreach_impl run_in_build_dir meson_src_compile
}

src_test() {
	python_foreach_impl run_in_build_dir meson_src_test
}

src_install() {
	installing() {
		meson_src_install
		python_doscript mozo
	}

	python_foreach_impl run_in_build_dir installing
}