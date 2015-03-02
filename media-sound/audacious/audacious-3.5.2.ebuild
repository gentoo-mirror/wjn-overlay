# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MY_P="${P/_/-}"

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://distfiles.audacious-media-player.org/${MY_P}.tar.bz2
	 mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="chardet"

RDEPEND=">=dev-libs/glib-2.28
	dev-libs/libxml2
	>=x11-libs/cairo-1.2.6
	>=x11-libs/pango-1.8.0
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
	chardet? ( >=app-i18n/libguess-1.1 )"
PDEPEND="~media-plugins/audacious-plugins-3.5.2"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf --enable-dbus \
		$(use_enable chardet)
}

src_install() {
	default
	dodoc AUTHORS

	# Gentoo_ice skin installation; bug #109772
	insinto /usr/share/audacious/Skins/gentoo_ice
	doins "${WORKDIR}"/gentoo_ice/*
	docinto gentoo_ice
	dodoc "${WORKDIR}"/README
}
