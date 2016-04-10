# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="MATE Settings Daemon"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="X -debug -gtk3 libnotify policykit pulseaudio smartcard"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.74:0
	>=dev-libs/glib-2.36:2
	~mate-base/libmatekbd-9999:0[gtk3=]
	~mate-base/mate-desktop-9999:0[gtk3=]
	media-libs/fontconfig:1.0
	~media-libs/libmatemixer-9999:0
	>=gnome-base/dconf-0.13.4:0
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/libX11:0
	x11-libs/libXi:0
	x11-libs/libXext:0
	x11-libs/libXxf86misc:0
	>=x11-libs/libxklavier-5:0
	virtual/libintl:0
	!gtk3? ( >=x11-libs/gtk+-2.24.0:2
		media-libs/libcanberra:0[gtk] )
	gtk3? ( >=x11-libs/gtk+-3.0.0:3
		media-libs/libcanberra:0[gtk3] )
	libnotify? ( >=x11-libs/libnotify-0.7:0 )
	policykit? ( >=dev-libs/dbus-glib-0.71:0
		>=sys-apps/dbus-1.1.2:0
		>=sys-auth/polkit-0.97:0 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.15:0 )
	smartcard? ( >=dev-libs/nss-3.11.2:0 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.37.1:0
	sys-devel/gettext:0
	virtual/pkgconfig:0
	x11-proto/inputproto:0
	x11-proto/xproto:0"
RDEPEND=${COMMON_DEPEND}

DOCS=( AUTHORS NEWS README )

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
		$(use_with X x) \
		$(use_enable debug) \
		--with-gtk=$(usex gtk3 '3.0' '2.0') \
		$(use_with libnotify) \
		$(use_enable policykit polkit) \
		$(use_enable pulseaudio pulse) \
		$(use_enable smartcard smartcard-support)
}
