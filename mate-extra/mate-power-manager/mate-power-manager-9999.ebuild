# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="no"

inherit autotools git-r3 gnome2

DESCRIPTION="A session daemon for MATE that makes it easy to manage your laptop or desktop system"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="+applet gnome-keyring man policykit test"

RESTRICT="test"

COMMON_DEPEND="app-text/rarian:0
	>=dev-libs/dbus-glib-0.70:0
	>=dev-libs/glib-2.13:2
	>=media-libs/libcanberra-0.10:0[gtk]
	>=sys-apps/dbus-1:0
	|| ( >=sys-power/upower-0.9.23:=
		>=sys-power/upower-pm-utils-0.9.23 )
	>=x11-apps/xrandr-1.2:0
	>=x11-libs/cairo-1:0
	>=x11-libs/gdk-pixbuf-2.11:2
	>=x11-libs/gtk+-2.17.7:2
	x11-libs/libX11:0
	x11-libs/libXext:0
	x11-libs/libXrandr:0
	>=x11-libs/libnotify-0.7:0
	x11-libs/pango:0
	applet? ( ~mate-base/mate-panel-9999 )
	gnome-keyring? ( >=gnome-base/libgnome-keyring-3:0 )"

DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.3
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	>=dev-util/intltool-0.35:*
	x11-proto/randrproto:0
	>=x11-proto/xproto-7.0.15:0
	sys-devel/gettext:*
	virtual/pkgconfig:*
	man? ( app-text/docbook-sgml-utils:0
		>=app-text/docbook-sgml-dtd-4.3 )"

RDEPEND="${COMMON_DEPEND}
	policykit? ( ~mate-extra/mate-polkit-9999 )"

DOCS=( AUTHORS HACKING NEWS NEWS.GNOME README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	sed -i 's/	GTK_WIDGET_UNSET_FLAGS (applet->popup, GTK_TOPLEVEL);//g' \
		applets/brightness/brightness-applet.c
	eautoreconf
	gnome2_src_prepare

	# This needs to be after eautoreconf to prevent problems like bug #356277
	# Remove the docbook2man rules here since it's not handled by a proper
	# parameter in configure.in.
	if ! use man; then
		sed -e 's:@HAVE_DOCBOOK2MAN_TRUE@.*::' -i man/Makefile.in \
			|| die "docbook sed failed"
	fi
}

src_configure() {
	gnome2_src_configure \
		$(use_enable applet applets) \
		$(use_enable test tests) \
		$(use_with gnome-keyring keyring) \
		--enable-compile-warnings=minimum \
		--with-gtk=2.0
}