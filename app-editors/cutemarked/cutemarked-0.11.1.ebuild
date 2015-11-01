# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="Qt5 markdown editor"
HOMEPAGE="https://github.com/cloose/CuteMarkEd"
SRC_URI="https://github.com/cloose/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/linguist-tools:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qttest:5
	dev-qt/qtwebkit:5[printsupport]
	app-text/discount
	app-text/hunspell
	!!app-text/cutemarked"
RDEPEND="${DEPEND}"

S="${WORKDIR}/CuteMarkEd-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}"-respect-destdir.patch
}

src_configure() {
	eqmake5 ROOT="${D}" CuteMarkEd.pro
}
