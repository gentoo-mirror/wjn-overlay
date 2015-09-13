# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="no"

inherit autotools git-r3 gnome2

DESCRIPTION="Applet showing network traffic for MATE"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS=""

COMMON_DEPEND=">=dev-libs/glib-2.36:2
	>=gnome-base/libgtop-2.14.2:2
	~mate-base/mate-panel-9999:0
	>=net-wireless/wireless-tools-28_pre9:0
	x11-libs/gdk-pixbuf:2
	x11-libs/pango:0
	virtual/libintl:0
	|| ( x11-libs/gtk+:2
		x11-libs/gtk+:3 )"
DEPEND="${COMMON_DEPEND}
	app-text/yelp-tools:0
	>=dev-util/intltool-0.50.1:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS NEWS README TODO )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}
