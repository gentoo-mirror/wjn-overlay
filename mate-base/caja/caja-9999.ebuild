# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Caja file manager for the MATE desktop"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS=""

IUSE="+mate +introspection +unique xmp"

COMMON_DEPEND="dev-libs/atk:0
	>=dev-libs/glib-2.28:2
	>=dev-libs/libxml2-2.4.7:2
	gnome-base/dconf:0
	>=gnome-base/gvfs-1.10.1:0[udisks]
	~mate-base/mate-desktop-9999
	>=media-libs/libexif-0.5.12:0
	>=x11-libs/gtk+-2.24:2[introspection?]
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/libICE:0
	x11-libs/libSM:0
	x11-libs/libX11:0
	x11-libs/libXext:0
	x11-libs/libXft:0
	x11-libs/libXrender:0
	>=x11-libs/pango-1.1.2:0
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.4:0 )
	unique? ( >=dev-libs/libunique-1:1 )
	xmp? ( >=media-libs/exempi-1.99.2:2 )
"
DEPEND="${COMMON_DEPEND}
	!!mate-base/mate-file-manager
	>=dev-lang/perl-5:0=
	dev-util/gdbus-codegen:0
	>=dev-util/intltool-0.40.1:*
	~mate-base/mate-common-9999
	sys-apps/sed
	sys-devel/gettext:*
	virtual/pkgconfig:*"
RDEPEND="${COMMON_DEPEND}"
PDEPEND="mate? ( ~x11-themes/mate-icon-theme-9999 )"

RESTRICT="test"

DOCS=( AUTHORS HACKING MAINTAINERS NEWS README README.commits THANKS TODO )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf

	# Remove unnecessary CFLAGS.
	sed -i -e 's:-DG.*DISABLE_DEPRECATED::g' \
		configure{,.ac} eel/Makefile.{am,in} || die

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--enable-unique \
		--disable-packagekit \
		--disable-update-mimedb \
		--with-gtk=2.0 \
		$(use_enable introspection) \
		$(use_enable unique) \
		$(use_enable xmp)
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "Caja can use gstreamer to preview audio files. Just make sure"
	elog "to have the necessary plugins available to play the media type you"
	elog "want to preview."
}
