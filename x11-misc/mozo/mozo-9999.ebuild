# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python3_{5,6,7} )
PYTHON_REQ_USE="xml"

inherit autotools git-r3 gnome2 python-r1

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
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40:0
	sys-apps/sed:0
	>=sys-devel/gettext-0.19.8:0
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

	has_version ">=sys-devel/gettext-0.20" \
		&& sed -i -e '/AM_GNU_GETTEXT_VERSION/s/19\.8/20/' configure.ac

	eapply_user
	eautoreconf
	gnome2_src_prepare
	python_copy_sources
}

src_configure() {
	python_foreach_impl run_in_build_dir gnome2_src_configure \
		--disable-icon-update
}

src_compile() {
	python_foreach_impl run_in_build_dir gnome2_src_compile
}

src_test() {
	python_foreach_impl run_in_build_dir emake check
}

src_install() {
	installing() {
		gnome2_src_install

		# Massage shebang to make python_doscript happy
		sed -e 's:#! '"${PYTHON}:#!/usr/bin/python:" \
			-i mozo || die

		python_doscript mozo
	}

	python_foreach_impl run_in_build_dir installing
}
