# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

MY_P="${P/_/-}"

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://distfiles.audacious-media-player.org/${MY_P}.tar.bz2
	 mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="chardet +gtk qt5"

COMMON_DEPEND=">=dev-libs/glib-2.28
	dev-libs/libxml2
	>=sys-apps/dbus-0.6.0
	>=sys-devel/gcc-4.7.0
	>=x11-libs/cairo-1.2.6
	>=x11-libs/pango-1.8.0
	chardet? ( >=app-i18n/libguess-1.2 )
	gtk? ( x11-libs/gtk+:2 )
	qt5? ( dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtmultimedia:5
		dev-qt/qtwidgets:5 )"
DEPEND="${COMMON_DEPEND}
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig"
RDEPEND=${COMMON_DEPEND}
PDEPEND="~media-plugins/audacious-plugins-3.6[gtk=,qt5=]"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	use qt5 && export PATH="/usr/$(get_libdir)/qt5/bin:${PATH}"
}

src_configure() {
	econf --enable-dbus \
		$(use_enable chardet) \
		$(use_enable gtk) \
		$(use_enable qt5 qt)
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

pkg_postinst() {
	if use qt5 && use gtk ; then
		ewarn 'It is not possible to switch between GTK+ and Qt while Audacious is running.'
		ewarn 'Run audacious --qt to get the Qt interface.'
	fi
}