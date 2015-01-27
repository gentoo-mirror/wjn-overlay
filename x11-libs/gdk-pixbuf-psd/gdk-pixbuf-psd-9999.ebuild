# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools git-2 gnome2-utils

DESCRIPTION="A GdkPixbuf loader for Adobe Photoshop images"
HOMEPAGE="http://cgit.sukimashita.com/gdk-pixbuf-psd.git/"
EGIT_REPO_URI="git://git.sukimashita.com/gdk-pixbuf-psd.git"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="-static"

COMMON_DEPEND="
	>=x11-libs/gdk-pixbuf-2.0
	"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/glib-2.0
	"
RDEPEND="${COMMON_DEPEND}"

DOCS=( README )

src_prerpare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable static)
}

src_install() {
	default
	# Get rid of the .la files.
	find "${D}" -name '*.la' -delete
}

pkg_preinst() {
	gnome2_gdk_pixbuf_savelist
}

pkg_postinst() {
	gnome2_gdk_pixbuf_update
}

pkg_postrm() {
	gnome2_gdk_pixbuf_update
}
