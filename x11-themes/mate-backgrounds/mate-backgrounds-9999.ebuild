# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GCONF_DEBUG="no"

inherit autotools git-r3 gnome2

DESCRIPTION="A set of backgrounds packaged with the MATE desktop"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="CC-BY-SA-4.0 GPL-2+"
SLOT="0"
KEYWORDS=""

DEPEND=">=dev-util/intltool-0.35:*
	sys-devel/gettext:*"

DOCS=( AUTHORS NEWS NEWS.GNOME README )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}
