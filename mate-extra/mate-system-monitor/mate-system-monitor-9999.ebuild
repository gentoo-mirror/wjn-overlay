# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="no"

inherit autotools git-r3 gnome2

DESCRIPTION="The MATE System Monitor"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="app-text/rarian:0
	>=dev-cpp/glibmm-2.16:2
	>=dev-cpp/gtkmm-2.22:2.4
	>=dev-libs/dbus-glib-0.70:0
	>=dev-libs/glib-2.28:2
	dev-libs/libsigc++:2
	>=dev-libs/libxml2-2:2
	>=gnome-base/libgtop-2.23.1:2=
	>=gnome-base/librsvg-2.12:2
	>=sys-apps/dbus-0.7:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.20:2
	>=x11-libs/libwnck-2.5:1
	~x11-themes/mate-icon-theme-9999
	virtual/libintl:0"
DEPEND="${COMMON_DEPEND}
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	>=dev-util/intltool-0.35:*
	sys-devel/gettext:*
	virtual/pkgconfig:*"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS NEWS NEWS.GNOME README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}
