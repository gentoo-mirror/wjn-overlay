# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="The MATE panel"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS=""

IUSE="X +introspection"

COMMON_DEPEND="dev-libs/atk:0
	>=dev-libs/dbus-glib-0.80:0
	>=dev-libs/glib-2.36:2
	~dev-libs/libmateweather-9999:0
	dev-libs/libxml2:2
	>=gnome-base/dconf-0.10.0:0
	gnome-base/librsvg:2
	~mate-base/mate-desktop-9999:0
	~mate-base/mate-menus-9999:0
	>=media-libs/libcanberra-0.23:0[gtk]
	>=sys-apps/dbus-1.1.2:0
	>=x11-libs/cairo-1:0
	>=x11-libs/gdk-pixbuf-2.7.1:2
	x11-libs/libICE:0
	x11-libs/libSM:0
	x11-libs/libX11:0
	>=x11-libs/libwnck-2.30:1[introspection?]
	>=x11-libs/pango-1.15.4:0[introspection?]
	>=x11-libs/gtk+-2.19.7:2[introspection?]
	x11-libs/libXau:0
	>=x11-libs/libXrandr-1.3.0:0
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.7:0 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/yelp-tools:0
	>=dev-lang/perl-5:0=
	>=dev-util/intltool-0.50.1:0
	~mate-base/mate-common-9999:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS HACKING NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	# Disable python check.
	sed -e '/AM_PATH_PYTHON/d' -i configure.ac || die
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--libexecdir=/usr/libexec/mate-applets \
		--disable-deprecation-flags \
		$(use_enable introspection) \
		$(use_with X x)
}
