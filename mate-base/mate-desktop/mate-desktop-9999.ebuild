# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python2_6 python2_7 )

inherit autotools git-r3 gnome2 multilib python-r1

DESCRIPTION="Libraries for the MATE desktop that are not part of the UI"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS=""

IUSE="X doc startup-notification"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="${PYTHON_DEPS}
	>=dev-libs/glib-2.36:2
	>=dev-libs/libunique-1:1
	x11-libs/cairo:0
	>=x11-libs/gdk-pixbuf-2.4:2
	>=x11-libs/gtk+-2.24:2
	x11-libs/libX11:0
	>=x11-libs/libXrandr-1.2:0
	virtual/libintl:0
	startup-notification? ( >=x11-libs/startup-notification-0.5:0 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/yelp-tools:0
	>=dev-util/intltool-0.40:*
	>=gnome-base/dconf-0.10:0
	sys-devel/gettext:*
	>=x11-proto/randrproto-1.2:0
	x11-proto/xproto:0
	virtual/pkgconfig:*
	doc? ( >=dev-util/gtk-doc-1.4 )"
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
		--enable-mate-conf-import \
		--with-gtk=2.0 \
		$(use_with X x) \
		$(use_enable doc gtk-doc) \
		$(use_enable startup-notification)
}

src_install() {
	gnome2_src_install

	python_replicate_script "${ED}"/usr/bin/mate-conf-import

	# Remove installed files that cause collissions.
	rm -rf "${ED}"/usr/share/help/C/{lgpl,gpl,fdl}
}
