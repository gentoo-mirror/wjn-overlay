# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PLOCALES="de ja zh_CN zh_TW"

inherit cmake-utils l10n

DESCRIPTION="Japanese libkkc module for Fcitx"
HOMEPAGE="https://gitlab.com/fcitx/fcitx-kkc"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/fcitx/${PN}.git"
	EGIT_BRANCH="master"
else
	SRC_URI="https://download.fcitx-im.org/${PN}/${P}.tar.xz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="qt5"

COMMON_DEPEND=">=app-i18n/fcitx-4.2.8:4
	>=app-i18n/libkkc-0.2.3
	qt5? ( >=dev-qt/qtcore-5.7:5
		>=dev-qt/qtdbus-5.7:5
		>=dev-qt/qtgui-5.7:5
		>=dev-qt/qtwidgets-5.7:5 )"
DEPEND="${COMMON_DEPEND}
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0.8
	sys-devel/gettext
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	app-i18n/libkkc-data
	app-i18n/skk-jisyo"

RESTRICT="mirror"

PATCHES=( "${FILESDIR}/${PN}-0.1.1-add-direct-input.patch"
	"${FILESDIR}/${PN}-0.1.1-fix-keymap-conflict.patch" )

src_prepare() {
	cmake-utils_src_prepare

	disable_locale() {
		sed -i "s/ ${1}//" po/CMakeLists.txt
	}
	l10n_for_each_disabled_locale_do disable_locale
}

src_configure() {
	local mycmakeargs=( -DENABLE_QT=$(usex qt5 NO OFF) )
	cmake-utils_src_configure
}
