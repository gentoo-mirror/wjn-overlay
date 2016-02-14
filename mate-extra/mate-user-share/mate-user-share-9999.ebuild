# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2 multilib

DESCRIPTION="Package for user-level file sharing in MATE desktop environment"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X -gtk3"

COMMON_DEPEND=">=app-mobilephone/obex-data-server-0.4:0
	>=dev-libs/dbus-glib-0.70:0
	>=dev-libs/glib-2.15.2:2
	>=dev-libs/libunique-1:1
	~mate-base/caja-9999:0[gtk3=]
	>=x11-libs/gdk-pixbuf-2:2
	x11-libs/libX11:0
	x11-libs/pango:0
	>=x11-libs/libnotify-0.7:0
	>=www-apache/mod_dnssd-0.6:0
	>=www-servers/apache-2.2:2[apache2_modules_dav,apache2_modules_dav_fs,apache2_modules_authn_file,apache2_modules_auth_digest,apache2_modules_authz_groupfile]
	virtual/libintl:0
	!gtk3? ( media-libs/libcanberra:0[gtk]
		>=x11-libs/gtk+-2.24.0:2 )
	gtk3? (  media-libs/libcanberra:0[gtk3]
		>=x11-libs/gtk+-3.0.0:3 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/yelp-tools:0
	>=dev-util/intltool-0.35.0:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS NEWS NEWS.GNOME README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-bluetooth \
		--with-httpd=apache2 \
		--with-modules-path=/usr/$(get_libdir)/apache2/modules/ \
		$(use_with X x) \
		--with-gtk=$(usex gtk3 '3.0' '2.0')
}
