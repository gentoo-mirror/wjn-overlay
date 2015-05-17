# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PLOCALES="de ja zh_CN zh_TW"

inherit cmake-utils eutils l10n

DESCRIPTION="Japanese libkkc module for Fcitx"
HOMEPAGE="https://github.com/fcitx/fcitx-kkc"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fcitx/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"
	KEYWORDS=""
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="qt4"

COMMON_DEPEND=">=app-i18n/fcitx-4.2.8[qt4?]
	>=app-i18n/libkkc-0.2.3
	qt4? ( >=dev-qt/qtcore-4.8:4
		>=dev-qt/qtdbus-4.8:4
		>=dev-qt/qtgui-4.8:4 )"
DEPEND="${COMMON_DEPEND}
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0.8
	sys-devel/gettext
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	app-i18n/libkkc-data
	app-i18n/skk-jisyo"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.1.1-add-direct-input.patch"
	epatch "${FILESDIR}/${PN}-0.1.1-fix-keymap-conflict.patch"
	epatch "${FILESDIR}/${PN}-0.1.1-add-dicts.patch"

	disable_locale() {
		sed -i "s/ ${1}//" po/CMakeLists.txt
	}
	l10n_for_each_disabled_locale_do disable_locale
}
