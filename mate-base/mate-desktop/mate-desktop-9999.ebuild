# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python2_7 )

inherit autotools git-r3 gnome2 python-r1

DESCRIPTION="Libraries for the MATE desktop that are not part of the UI"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X doc -gtk3 introspection startup-notification"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.36:2
	>=gnome-base/dconf-0.13.4:0
	x11-libs/cairo:0
	>=x11-libs/gdk-pixbuf-2.4:2[introspection?]
	x11-libs/libX11:0
	>=x11-libs/libXrandr-1.3:0
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.9.7:0 )
	startup-notification? ( >=x11-libs/startup-notification-0.5:0 )
	!gtk3? ( >=dev-libs/libunique-1.0:1
		>=x11-libs/gtk+-2.24.0:2[introspection?] )
	gtk3? ( >=x11-libs/gtk+-3.0.0:3[introspection?]
		>=dev-libs/libunique-3.0:3 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=dev-util/intltool-0.50.1:0
	>=gnome-base/dconf-0.10:0
	sys-devel/gettext:0
	>=x11-proto/randrproto-1.2:0
	x11-proto/xproto:0
	virtual/pkgconfig:0
	doc? ( >=dev-util/gtk-doc-1.4:0 )"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog HACKING MAINTAINERS NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--enable-mate-about \
		$(use_with X x) \
		$(use_enable doc gtk-doc) \
		--with-gtk=$(usex gtk3 '3.0' '2.0') \
		$(use_enable introspection) \
		$(use_enable startup-notification)
}

src_install() {
	gnome2_src_install

	# Remove installed files that cause collissions.
	rm -rf "${ED}"/usr/share/help/C/{lgpl,gpl,fdl}
}
