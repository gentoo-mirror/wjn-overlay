# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit

MY_PN="gedit-markdown"

DESCRIPTION="Markdown bindings for gtksourceview"
HOMEPAGE="https://github.com/jpfleury/gedit-markdown"

SRC_URI="
https://raw.githubusercontent.com/jpfleury/${MY_PN}/v1/language-specs/markdown.lang
https://raw.githubusercontent.com/jpfleury/${MY_PN}/v1/language-specs/markdown-extra.lang
"

LICENSE="GPL-3"
SLOT="2.0"
KEYWORDS=""

DEPEND="
	x11-libs/gtksourceview:${SLOT}
	"
RDEPEND="${DEPEND}
	x11-libs/gtksourceview:${SLOT}
	"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}"/*.lang "${S}"
}

src_install() {
	insinto /usr/share/gtksourceview-${SLOT}/language-specs
	doins markdown.lang markdown-extra.lang
}
