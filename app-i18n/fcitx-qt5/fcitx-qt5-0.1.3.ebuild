# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils

DESCRIPTION="Fcitx support for Qt5"
HOMEPAGE="http://code.google.com/p/fcitx/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/fcitx/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="http://download.fcitx-im.org/fcitx-qt5/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2+"
SLOT="0"

DEPEND="
	app-i18n/fcitx
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtdbus:5
	"
RDEPEND="${DEPEND}"
