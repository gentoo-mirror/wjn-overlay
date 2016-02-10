# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools git-r3

DESCRIPTION="A theme set for MATE Desktop Environment"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND=">=x11-libs/gdk-pixbuf-2.0.0:2
	|| ( ( >=x11-libs/gtk+-2.0.0:2
			>=x11-themes/gtk-engines-2.15.3:2
			x11-themes/murrine-themes:0 )
		>=x11-libs/gtk+-3.16.0:3 )"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.35:0
	sys-devel/gettext:0
	>=x11-misc/icon-naming-utils-0.8.7:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

RESTRICT="binchecks strip"

DOCS=( AUTHORS NEWS README )

src_prepare() {
	eautoreconf
}
