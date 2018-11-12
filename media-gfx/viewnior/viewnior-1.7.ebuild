# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools gnome2-utils meson xdg-utils

MY_PN="Viewnior"

DESCRIPTION="Fast and simple image viewer"
HOMEPAGE="http://siyanpanayotov.com/project/viewnior/"
SRC_URI="https://github.com/hellosiyan/${MY_PN}/archive/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND=">=dev-libs/glib-2.32:2
	dev-util/desktop-file-utils
	>=media-gfx/exiv2-0.21:=
	>=x11-libs/gdk-pixbuf-0.21:2
	>=x11-libs/gtk+-2.20:2
	>=x11-misc/shared-mime-info-0.20"
DEPEND=${COMMON_DEPEND}
RDEPEND=${COMMON_DEPEND}

S="${WORKDIR}/${MY_PN}-${P}"

DOCS=( AUTHORS NEWS README.md TODO )

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}