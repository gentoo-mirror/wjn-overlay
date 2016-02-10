# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="MATE keyboard configuration library"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X -gtk3 introspection test"

DOCS=( AUTHORS NEWS README )

COMMON_DEPEND=">=dev-libs/glib-2.18:2
	x11-libs/cairo:0
	>=x11-libs/gdk-pixbuf-2.18:2[introspection?]
	x11-libs/libX11:0
	>=x11-libs/libxklavier-5.0:0
	x11-libs/pango:0
	virtual/libintl:0
	!gtk3? ( >=x11-libs/gtk+-2.24.0:2[introspection?] )
	gtk3? ( >=x11-libs/gtk+-3.0.0:3[introspection?] )"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext:0
	>=dev-util/intltool-0.50.1:0
	virtual/pkgconfig:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.7:0[cairo] )"
RDEPEND="${COMMON_DEPEND}"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		$(use_with X x) \
		--with-gtk=$(usex gtk3 '3.0' '2.0') \
		$(use_enable introspection) \
		$(use_enable test tests)
}
