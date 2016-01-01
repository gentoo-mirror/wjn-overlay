# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools git-r3

DESCRIPTION="Documents for end-users of MATE"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="CC-BY-SA-3.0"
SLOT="0"
KEYWORDS=""

DEPEND=">=dev-util/intltool-0.40.0:0
	app-text/yelp-tools:0
	sys-devel/gettext:0"
RDEPEND=""

DOCS=( AUTHORS HACKING NEWS README )

src_prepare() {
	eautoreconf
}

pkg_postinst(){
	elog "gnome-extra/yelp is needed to parse documents fully."
}
