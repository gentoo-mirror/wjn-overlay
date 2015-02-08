# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="MATE keyboard configuration library"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""

IUSE="X test"

DOCS=( AUTHORS NEWS README )

COMMON_DEPEND=">=dev-libs/glib-2.18:2
	x11-libs/cairo:0
	>=x11-libs/gdk-pixbuf-2.18:2
	>=x11-libs/gtk+-2.18:2
	x11-libs/libX11:0
	>=x11-libs/libxklavier-5.0:0
	x11-libs/pango:0
	virtual/libintl:0"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext:*
	>=dev-util/intltool-0.35:*
	virtual/pkgconfig:*"
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
		--with-gtk=2.0 \
		$(use_enable test tests) \
		$(use_with X x)
}
