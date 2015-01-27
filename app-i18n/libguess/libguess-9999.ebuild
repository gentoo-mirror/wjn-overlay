# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit autotools git-2

DESCRIPTION="A high-speed character set detection library."
HOMEPAGE="http://atheme.org/projects/libguess.html"
EGIT_REPO_URI="git://github.com/atheme/${PN}.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="examples"

RDEPEND="
	=dev-libs/libmowgli-9999"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( README )

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable examples)
}


