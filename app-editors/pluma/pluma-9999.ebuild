# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

PYTHON_COMPAT=( python2_{6,7} )

inherit autotools git-r3 gnome2 multilib python-single-r1

DESCRIPTION="A powerful text editor for MATE"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="python spell"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RESTRICT="test"

COMMON_DEPEND="app-text/rarian:0
	dev-libs/atk:0
	>=dev-libs/glib-2.32:2
	>=dev-libs/libxml2-2.5:2
	~mate-base/mate-desktop-9999
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.19:2
	>=x11-libs/gtksourceview-2.9.7:2.0
	x11-libs/libICE:0
	x11-libs/libX11:0
	>=x11-libs/libSM-1.0
	x11-libs/pango:0
	virtual/libintl:0
	python? ( ${PYTHON_DEPS}
		>=dev-python/pygobject-2.15.4:2[${PYTHON_USEDEP}]
		>=dev-python/pygtk-2.12:2[${PYTHON_USEDEP}]
		>=dev-python/pygtksourceview-2.9.2:2 )
	spell? ( >=app-text/enchant-1.2:0
		>=app-text/iso-codes-0.35:0 )
	!!app-editors/mate-text-editor"
DEPEND="${COMMON_DEPEND}
	~app-text/docbook-xml-dtd-4.1.2
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	dev-util/gtk-doc
	>=dev-util/intltool-0.40:*
	~mate-base/mate-common-9999
	>=sys-devel/gettext-0.17:*
	>=sys-devel/libtool-2.2.6:2
	virtual/pkgconfig:*"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS HACKING NEWS NEWS.GNOME README )

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
		--disable-updater \
		$(use_enable python) \
		$(use_enable spell)
}