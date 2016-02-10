# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Qt5 input module for Fcitx"
HOMEPAGE="https://fcitx-im.org/
	https://github.com/fcitx/fcitx-qt5"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/${PN}.git"
else
	SRC_URI="http://download.fcitx-im.org/fcitx-qt5/${P}.tar.xz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND=">=app-i18n/fcitx-4.2.9
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	>=x11-libs/libxkbcommon-0.5.0"
DEPEND="${COMMON_DEPEND}
	kde-frameworks/extra-cmake-modules:5"
RDEPEND="${COMMON_DEPEND}"

RESTRICT="mirror"
