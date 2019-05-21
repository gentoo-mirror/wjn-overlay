# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="A set of backgrounds packaged with MATE desktop"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="CC-BY-SA-4.0 GPL-2+"
SLOT="0"
KEYWORDS=""

BDEPEND=">=dev-util/intltool-0.35.0:0
	sys-devel/gettext:0"
RDEPEND=""

DOCS=( AUTHORS ChangeLog NEWS README )

src_unpack() {
	git-r3_src_unpack
}