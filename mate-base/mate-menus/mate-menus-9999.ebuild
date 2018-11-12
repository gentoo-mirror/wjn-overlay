# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="Library implements freedesktop.org specification to MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug +introspection"

COMMON_DEPEND=">=dev-libs/glib-2.50.0:2
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.7:0 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40:0
	mate-base/mate-common:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eapply_user
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	local myconf
	myconf="${myconf} \
		$(use_enable introspection)"

	# Do NOT compile with --disable-debug/--enable-debug=no as it disables API
	# usage checks.
	if ! use debug ; then
		myconf="${myconf} --enable-debug=minimum"
	fi

	gnome2_src_configure ${myconf}
}

src_install() {
	gnome2_src_install

	exeinto /etc/X11/xinit/xinitrc.d/
	doexe "${FILESDIR}/10-xdg-menu-mate"
}
