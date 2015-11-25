# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools git-r3 gnome2-utils multilib

DESCRIPTION="A gdk-pixbuf loader for xcf (The Gimp) files"
HOMEPAGE="https://gitorious.org/xcf-pixbuf-loader/"
EGIT_REPO_URI="https://gitorious.org/xcf-pixbuf-loader/mainline.git"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="-static"

COMMON_DEPEND=">=x11-libs/gdk-pixbuf-2.0"
DEPEND="${COMMON_DEPEND}
	>=dev-libs/glib-2.0"
RDEPEND="${COMMON_DEPEND}"

RESTRICT="mirror"

DOCS=( README )

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --libdir=/usr/$(get_libdir)/gdk-pixbuf-2.0/2.10.0/loaders/ \
	$(use_enable static)
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