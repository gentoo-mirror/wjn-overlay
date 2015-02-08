# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Multimedia related programs for the MATE desktop"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2 GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS=""

IUSE=""

COMMON_DEPEND="app-text/rarian:0
	dev-libs/libxml2:2
	>=dev-libs/glib-2.18.2:2
	dev-libs/libunique:1
	~mate-base/mate-panel-9999
	~mate-base/mate-desktop-9999
	~mate-extra/libmatemixer-9999
	>=media-libs/libcanberra-0.13:0[gtk]
	>=dev-libs/libunique-1:1
	x11-libs/cairo:0
	>=x11-libs/gtk+-2.24:2
	x11-libs/pango:0
	virtual/libintl:0"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/yelp-tools:0
	>=app-text/scrollkeeper-dtd-1:1.0
	>=dev-util/intltool-0.35.0:*
	sys-devel/gettext:*
	virtual/pkgconfig:*
	~mate-base/mate-applets-9999"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}
