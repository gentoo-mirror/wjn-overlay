# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Configuration tool for MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="appindicator debug"

COMMON_DEPEND="app-text/rarian:0
	dev-libs/atk:0
	>=dev-libs/dbus-glib-0.73:0
	>=dev-libs/glib-2.50.0:2
	dev-libs/libxml2:2
	>=gnome-base/dconf-0.13.4:0
	>=gnome-base/librsvg-2.0:2
	>=mate-base/libmatekbd-1.17.0:0
	>=mate-base/mate-desktop-1.21.1:0
	>=mate-base/caja-1.17.0:0
	>=mate-base/mate-menus-1.1.0:0
	>=mate-base/mate-settings-daemon-1.17.0:0
	>=media-libs/fontconfig-1:1.0
	media-libs/freetype:2
	media-libs/libcanberra:0[gtk3]
	>=sys-apps/accountsservice-0.6.21
	>=sys-apps/dbus-1:0
	x11-apps/xmodmap:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.22.0:3
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
	>=x11-wm/marco-1.17.0
	virtual/libintl:0
	appindicator? ( >=dev-libs/libappindicator-0.0.13:3 )"
DEPEND="${COMMON_DEPEND}
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	dev-util/desktop-file-utils:0
	>=dev-util/intltool-0.50.1:0
	mate-base/mate-common:0
	sys-devel/gettext:0
	virtual/pkgconfig:0
	x11-base/xorg-proto"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-update-mimedb \
		--with-accountsservice \
		$(use_enable appindicator)
}
