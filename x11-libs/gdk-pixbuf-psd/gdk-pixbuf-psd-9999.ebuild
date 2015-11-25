# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools gnome2-utils

DESCRIPTION="A GdkPixbuf loader for Adobe Photoshop images"
HOMEPAGE="http://cgit.sukimashita.com/gdk-pixbuf-psd.git/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="http://git.sukimashita.com/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="http://cgit.sukimashita.com/${PN}.git/snapshot/${P}.tar.bz2"
	KEYWORDS="~alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86
		~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux
		~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris
		~sparc64-solaris ~x64-solaris ~x86-solaris"
fi

LICENSE="LGPL-2.1"
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