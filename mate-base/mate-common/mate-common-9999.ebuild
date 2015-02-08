# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-r3

DESCRIPTION="Common files for development of MATE packages"
HOMEPAGE="http://mate-desktop.org/"
EGIT_REPO_URI="git://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DOCS=( AUTHORS NEWS README )

src_prepare() {
	eautoreconf
}

src_install() {
	mv doc-build/README README.doc-build \
		|| die "Failed to rename doc-build/README."

	default

	dodoc doc/usage.txt
}
