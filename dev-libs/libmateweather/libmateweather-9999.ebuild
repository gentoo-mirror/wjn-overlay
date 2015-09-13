# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_7 )

inherit autotools git-r3 gnome2 python-r1

DESCRIPTION="MATE library to access weather information from online services"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="-gtk3 python"
REQUIRED_USE="gtk3? ( !python )
	python? ( ${PYTHON_REQUIRED_USE} )"

COMMON_DEPEND=">=dev-libs/glib-2.36.0:2[${PYTHON_USEDEP}]
	>=dev-libs/libxml2-2.6.0:2
	>=net-libs/libsoup-2.34.0:2.4
	>=sys-libs/timezone-data-2010k:0
	x11-libs/gdk-pixbuf:2
	virtual/libintl:0
	!gtk3? ( >=x11-libs/gtk+-2.24.0:2 )
	gtk3? ( >=x11-libs/gtk+-3.0.0:3 )
	python? ( ${PYTHON_DEPS}
		>=dev-python/pygobject-2:2[${PYTHON_USEDEP}]
		>=dev-python/pygtk-2:2[${PYTHON_USEDEP}] )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.50.1:0
	~mate-base/mate-common-9999:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS NEWS NEWS.GNOME README )

my_command() {
	if use python ; then
		python_foreach_impl run_in_build_dir $@
	else
		$@
	fi
}

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	# Fix undefined use of MKDIR_P in python/Makefile.am.
	epatch "${FILESDIR}"/${PN}-1.6.1-fix-mkdirp.patch
	eautoreconf

	use python && python_copy_sources
	my_command gnome2_src_prepare
}

src_configure() {
	my_command gnome2_src_configure \
		--enable-locations-compression \
		--disable-all-translations-in-one-xml \
		--with-gtk=$(usex gtk3 '3.0' '2.0') \
		$(use_enable python)
}

src_compile() {
	my_command gnome2_src_compile
}

src_install() {
	my_command gnome2_src_install
}
