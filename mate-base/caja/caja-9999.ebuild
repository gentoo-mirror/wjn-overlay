# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Caja file manager for the MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS=""
IUSE="doc extensions dropbox -gtk3 +mate +introspection python +unique xmp"

COMMON_DEPEND="dev-libs/atk:0[introspection?]
	dev-libs/glib:2
	>=dev-libs/libxml2-2.4.7:2
	gnome-base/dconf:0
	>=gnome-base/gvfs-1.10.1:0[udisks]
	~mate-base/mate-desktop-9999:0[gtk3?]
	>=media-libs/libexif-0.6.14:0
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
	!gtk3? ( >=x11-libs/gtk+-2.24.0:2[introspection?] )
	gtk3? ( >=x11-libs/gtk+-3.0.0:3[introspection?] )
	introspection? ( >=dev-libs/gobject-introspection-0.6.4:0 )
	unique? ( !gtk3? ( >=dev-libs/libunique-1:1 )
		gtk3? ( >=dev-libs/libunique-3.0:3 ) )
	xmp? ( >=media-libs/exempi-1.99.5:2 )"
DEPEND="${COMMON_DEPEND}
	>=dev-lang/perl-5:0=
	dev-util/gdbus-codegen:0
	>=dev-util/intltool-0.50.1:0
	~mate-base/mate-common-9999:0
	sys-apps/sed:0
	sys-devel/gettext:0
	virtual/pkgconfig:0
	doc? ( >=dev-util/gtk-doc-1.4:0 )
	!!mate-base/mate-file-manager:*"
RDEPEND="${COMMON_DEPEND}"
PDEPEND="extensions? ( ~mate-extra/caja-extensions-9999:0 )
	dropbox? ( ~mate-extra/caja-dropbox-9999:0 )
	mate? ( ~x11-themes/mate-icon-theme-9999:0 )
	python? ( ~dev-python/python-caja-9999:0 )"

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
		$(use_enable doc gtk-doc) \
		--with-gtk=$(usex gtk3 '3.0' '2.0') \
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
