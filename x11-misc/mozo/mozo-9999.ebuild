# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="xml"

inherit autotools git-r3 gnome2 python-r1

DESCRIPTION="Menu editor for MATE using the freedesktop.org menu specification"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND=">=dev-python/pygobject-2.15.1:2[${PYTHON_USEDEP}]
	>=dev-python/pygtk-2.13.0:2[${PYTHON_USEDEP}]
	~mate-base/mate-menus-9999:0[introspection,python]"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40:0
	sys-apps/sed:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}
	${PYTHON_DEPS}
	~mate-base/mate-panel-9999:0
	x11-libs/gdk-pixbuf:2[introspection]
	x11-libs/gtk+:2[introspection]
	virtual/libintl:0
	!!x11-misc/mate-menu-editor:*"

DOCS=( AUTHORS NEWS NEWS.GNOME README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
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