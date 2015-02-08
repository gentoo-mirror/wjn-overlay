# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit autotools git-r3  gnome2

DESCRIPTION="The MATE Desktop configuration tool"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="app-text/rarian:0
	dev-libs/atk:0
	>=dev-libs/dbus-glib-0.73:0
	>=dev-libs/glib-2.28:2
	>=dev-libs/libunique-1:1
	dev-libs/libxml2:2
	>=gnome-base/dconf-0.13.4:0
	>=gnome-base/librsvg-2.0:2
	~mate-base/libmatekbd-9999
	~mate-base/mate-desktop-9999
	~mate-base/caja-9999
	~mate-base/mate-menus-9999
	~mate-base/mate-settings-daemon-9999
	>=media-libs/fontconfig-1:1.0
	media-libs/freetype:2
	media-libs/libcanberra:0[gtk]
	>=sys-apps/dbus-1:0
	x11-apps/xmodmap:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.24:2
	x11-libs/libX11:0
	x11-libs/libXScrnSaver:0
	x11-libs/libXcursor:0
	x11-libs/libXext:0
	x11-libs/libXft:0
	>=x11-libs/libXi-1.2:0
	x11-libs/libXrandr:0
	x11-libs/libXrender:0
	x11-libs/libXxf86misc:0
	>=x11-libs/libxklavier-4:0
	x11-libs/pango:0
	~x11-wm/marco-9999
	virtual/libintl:0"
DEPEND="${COMMON_DEPEND}
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	dev-util/desktop-file-utils:0
	>=dev-util/intltool-0.37.1:*
	~mate-base/mate-common-9999
	sys-devel/gettext:*
	x11-proto/kbproto:0
	x11-proto/randrproto:0
	x11-proto/renderproto:0
	x11-proto/scrnsaverproto:0
	x11-proto/xextproto:0
	x11-proto/xf86miscproto:0
	x11-proto/xproto:0
	virtual/pkgconfig:*"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS NEWS README TODO )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-update-mimedb \
		--disable-appindicator
}
