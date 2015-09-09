# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="no"

inherit autotools git-r3 gnome2 versionator

DESCRIPTION="A set of MATE themes, with sets for users with limited or low vision"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND=">=x11-libs/gdk-pixbuf-2:2
	>=x11-libs/gtk+-2:2
	>=x11-themes/gtk-engines-2.15.3:2
	x11-themes/murrine-themes:0"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.35:*
	sys-devel/gettext:*
	>=x11-misc/icon-naming-utils-0.8.7:0
	virtual/pkgconfig:*"
RDEPEND="${COMMON_DEPEND}"

RESTRICT="binchecks strip"

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
		--enable-icon-mapping
}
