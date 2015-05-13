# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: #

EAPI=5

inherit fdo-mime gnome2-utils autotools

MY_PN="Viewnior"

DESCRIPTION="Fast and simple image viewer"
HOMEPAGE="http://xsisqox.github.com/Viewnior/index.html"
SRC_URI="https://github.com/xsisqox/${MY_PN}/archive/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND=">=dev-libs/glib-2.32:2
	>=media-gfx/exiv2-0.21
	>=x11-libs/gtk+-2.20:2
	>=x11-misc/shared-mime-info-0.20"
RDEPEND="${DEPEND}
	x11-libs/gdk-pixbuf:2"

S="${WORKDIR}/${MY_PN}-${P}"

DOCS="AUTHORS ChangeLog* NEWS README TODO"

src_prepare() {
	eautoreconf
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}