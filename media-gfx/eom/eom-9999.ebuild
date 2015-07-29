# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="yes"
PYTHON_COMPAT=( python2_{6,7} )

inherit autotools git-r3 gnome2 python-single-r1

DESCRIPTION="The MATE image viewer"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="X dbus exif jpeg lcms python svg tiff xmp"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

COMMON_DEPEND="dev-libs/atk:0
	>=dev-libs/glib-2.25.9:2
	>=dev-libs/libxml2-2:2
	gnome-base/dconf:0
	~mate-base/mate-desktop-9999
	sys-libs/zlib:0
	x11-libs/cairo:0
	>=x11-libs/gdk-pixbuf-2.4:2[jpeg?,tiff?]
	>=x11-libs/gtk+-2.18:2
	x11-libs/libX11:0
	>=x11-misc/shared-mime-info-0.20:0
	~x11-themes/mate-icon-theme-9999
	virtual/libintl:0
	dbus? ( >=dev-libs/dbus-glib-0.71:0 )
	exif? ( >=media-libs/libexif-0.6.14:0
		virtual/jpeg:0 )
	jpeg? ( virtual/jpeg:0 )
	lcms? ( media-libs/lcms:2 )
	python? ( ${PYTHON_DEPS}
		>=dev-python/pygobject-2.15.1:2[${PYTHON_USEDEP}]
		>=dev-python/pygtk-2.13:2[${PYTHON_USEDEP}] )
	svg? ( >=gnome-base/librsvg-2.26:2 )
	xmp? ( >=media-libs/exempi-1.99.5:2 )
	!!media-gfx/mate-image-viewer"
DEPEND="${COMMON_DEPEND}
	app-text/yelp-tools:0
	>=dev-util/gtk-doc-1.9
	>=dev-util/intltool-0.40:*
	sys-devel/gettext:*
	virtual/pkgconfig:*"
RDEPEND="${COMMON_DEPEND}"
DOCS=( AUTHORS HACKING NEWS NEWS.gnome README THANKS TODO )

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		$(use_enable python) \
		$(use_with jpeg libjpeg) \
		$(use_with exif libexif) \
		$(use_with dbus) \
		$(use_with lcms cms) \
		$(use_with xmp) \
		$(use_with svg librsvg) \
		$(use_with X x) \
		--without-cms
}
