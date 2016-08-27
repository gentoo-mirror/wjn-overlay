# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="MATE utilities for netbooks"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug gtk3"

COMMON_DEPEND=">=dev-libs/glib-2.36:2
	~mate-base/mate-desktop-9999:0[gtk3=]
	~mate-base/mate-panel-9999:0[gtk3=]
	x11-libs/cairo:0
	x11-libs/libwnck:1
	x11-libs/libfakekey:0
	x11-libs/libXtst:0
	x11-libs/libX11:0
	virtual/libintl:0
	!gtk3? ( x11-libs/gtk+:2 )
	gtk3? (	x11-libs/gtk+:3 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.34:*
	sys-devel/gettext:*
	virtual/pkgconfig:*
	x11-proto/xproto:0"
RDEPEND=${COMMON_DEPEND}

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
	gnome2_src_configure \
		--with-gtk=$(usex gtk3 '3.0' '2.0')
}
