# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-r3

DESCRIPTION="Documents for end-users of MATE"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="CC-BY-SA-3.0"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="gnome-extra/yelp"

DOCS=( AUTHORS HACKING NEWS README )

src_prepare() {
	eautoreconf
}
