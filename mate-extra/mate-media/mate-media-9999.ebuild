# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Multimedia related programs for the MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2 GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS=""
IUSE="-gtk3"

COMMON_DEPEND="app-text/rarian:0
	dev-libs/libxml2:2
	>=dev-libs/glib-2.36.0:2
	~mate-base/mate-applets-9999[gtk3?]
	~mate-base/mate-panel-9999:0[gtk3?]
	~mate-base/mate-desktop-9999:0[gtk3=]
	>=media-libs/libcanberra-0.13:0[gtk,gtk3?]
	~media-libs/libmatemixer-9999:0
	x11-libs/cairo:0
	x11-libs/pango:0
	virtual/libintl:0
	!gtk3? ( >=dev-libs/libunique-1.0:1
		>=x11-libs/gtk+-2.24.0:2[introspection?] )
	gtk3? ( >=x11-libs/gtk+-3.0.0:3[introspection?]
		>=dev-libs/libunique-3.0:3 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/yelp-tools:0
	>=app-text/scrollkeeper-dtd-1:1.0
	>=dev-util/intltool-0.35.0:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}
	x11-themes/sound-theme-freedesktop"

DOCS=( AUTHORS NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--with-gtk=$(usex gtk3 '3.0' '2.0')
}
