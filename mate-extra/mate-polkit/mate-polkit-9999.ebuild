# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="no"

inherit autotools git-r3 gnome2

DESCRIPTION="A MATE specific DBUS session bus service that is used to bring up authentication dialogs"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""

IUSE="doc +introspection"

COMMON_DEPEND=">=dev-libs/glib-2.28:2
	>=sys-auth/polkit-0.102:0[introspection?]
	>=x11-libs/gtk+-2.24:2[introspection?]
	x11-libs/gdk-pixbuf:2[introspection?]
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.2:0 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-1.3:0
	>=dev-util/intltool-0.35:*
	~mate-base/mate-common-9999
	sys-devel/gettext:*
	virtual/pkgconfig:*
	!<gnome-extra/polkit-gnome-0.102:0"
RDEPEND="${COMMON_DEPEND}"
# Entropy PMS specific. This way we can install the pkg into the build chroots.
ENTROPY_RDEPEND="!lxde-base/lxpolkit"

DOCS=( AUTHORS HACKING NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		$(use_enable introspection)
}
