# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit autotools git-r3

DESCRIPTION="A high-speed character set detection library."
HOMEPAGE="http://atheme.org/projects/libguess.html"
EGIT_REPO_URI="git://github.com/kaniini/${PN}.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="examples"

DEPEND="=dev-libs/libmowgli-9999
	virtual/pkgconfig"
RDEPEND="=dev-libs/libmowgli-9999"

DOCS=( README )

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable examples)
}
