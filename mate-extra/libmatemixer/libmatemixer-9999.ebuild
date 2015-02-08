# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

ELTCONF="--portage"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Atril document viewer for MATE"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="alsa oss pulseaudio"

COMMON_DEPEND="
	>=dev-libs/glib-2.40.2
	>=dev-libs/gobject-introspection-1.38.0
	>=dev-libs/libxml2-2.5:2
	>=x11-libs/gtk+-2.21.5:2
	alsa? ( media-libs/alsa-lib )
	oss? ( virtual/os-headers )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-1.10
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	sys-devel/gettext"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	# Passing --disable-help would drop offline help, that would be inconsistent
	# with helps of the most of GNOME apps that doesn't require network for that.
	gnome2_src_configure \
		--enable-null \
		$(use_enable alsa) \
		$(use_enable oss) \
		$(use_enable pulseaudio)
}
