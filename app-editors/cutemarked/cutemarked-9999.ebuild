# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit base multilib

MY_P="CuteMarkEd-${PV}"
DESCRIPTION="A Qt5-based markdown editor with live HTML preview"
HOMEPAGE="http://cloose.github.io/CuteMarkEd/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/cloose/CuteMarkEd.git"
	EGIT_BRANCH="master"
else
	SRC_URI="https://github.com/cloose/CuteMarkEd/archive/v${PV}.tar.gz"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="BSD GPL-2+ MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=app-text/discount-2.1.6
	>=app-text/hunspell-1.3.2
	app-text/peg-markdown
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsql:5
	dev-qt/qttest:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	media-libs/libpng
	"
DEPEND="${RDEPEND}"

DOCS="README.md"

src_configure() {
	"/usr/$(get_libdir)/qt5/bin/qmake" CuteMarkEd.pro
}

src_compile() {
	emake -j1
}

src_install() {
	base_src_install INSTALL_ROOT="${D}" "$@"
	dodoc ${DOCS}
}

