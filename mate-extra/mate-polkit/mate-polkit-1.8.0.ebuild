# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="no"

inherit gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="A MATE specific DBUS session bus service that is used to bring up authentication dialogs"
HOMEPAGE="https://github.com/mate-desktop/mate-polkit"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="doc +introspection"

COMMON_DEPEND=">=dev-libs/glib-2.28:2
	>=sys-auth/polkit-0.102:0[introspection?]
	>=x11-libs/gtk+-2.24:2[introspection?]
	x11-libs/gdk-pixbuf:2[introspection?]
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.2:0 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.35:*
	mate-base/mate-common:0
	sys-devel/gettext:*
	virtual/pkgconfig:*
	!<gnome-extra/polkit-gnome-0.102:0
	doc? ( >=dev-util/gtk-doc-1.3:0 )"
RDEPEND="${COMMON_DEPEND}"
# Entropy PMS specific. This way we can install the pkg into the build chroots.
ENTROPY_RDEPEND="!lxde-base/lxpolkit"

DOCS=( AUTHORS HACKING NEWS README )

src_prepare() {
	if ! use doc; then
		sed -i 's/GTK_DOC_CHECK(\[1\.3\])//g' configure.ac;
		sed -i 's_docs/version\.xml__g' configure.ac;
		sed -i 's_docs/Makefile__g' configure.ac;
		sed -i 's/--enable-gtk-doc/--disable-gtk-doc/g' Makefile.am;
		sed -i 's/SUBDIRS = polkitgtkmate src po docs/SUBDIRS = polkitgtkmate src po/g' Makefile.am;
	fi
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		$(use_enable introspection)
}


