# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI=5

inherit gnome2-utils

DESCRIPTION="an extensible scalable virtual keyboard for X11"
HOMEPAGE="http://florence.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc libnotify"

RDEPEND=""
DEPEND="${RDEPEND}
	gnome-base/librsvg
	>=dev-libs/libxml2-2.0
	>=dev-util/intltool-0.23
	gnome-base/gconf:2
	>=gnome-base/libglade-2.0
	sys-devel/gettext
	x11-libs/cairo
	>=x11-libs/gtk+-2.1
	x11-libs/libXtst
	doc? (
		app-text/gnome-doc-utils
	)
	libnotify? (
		x11-libs/libnotify
	)
	"

DOCS=( README NEWS )

src_configure() {
	econf \
		--with-xtst \
		$(use_with doc docs ) \
		$(use_with libnotify notification )

}

src_compile() {
	emake -j1
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}

