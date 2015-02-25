# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="no"

inherit autotools git-r3 gnome2

DESCRIPTION="The MATE Terminal Emulator"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
COMMON_DEPEND="app-text/rarian:0
	dev-libs/atk:0
	>=dev-libs/glib-2.25:2
	>=gnome-base/dconf-0.10:0
	~mate-base/mate-desktop-9999
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.18:2
	x11-libs/libICE:0
	x11-libs/libSM:0
	x11-libs/libX11:0
	x11-libs/pango:0
	>=x11-libs/vte-0.27.1:0"
DEPEND="${COMMON_DEPEND}
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	>=dev-util/intltool-0.40:*
	sys-devel/gettext:*
	virtual/pkgconfig:*"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS HACKING NEWS NEWS.GNOME README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	sed -i 's/g_variant_get (parameters, "(@ay@ay@ay@ay@i@ay)",/g_variant_get (parameters, "(@ay@ay@ay@ayi@ay)",/' src/terminal.c
	eautoreconf
	gnome2_src_prepare
}
