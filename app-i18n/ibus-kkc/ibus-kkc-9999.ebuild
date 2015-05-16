# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-r3 vala

DESCRIPTION="Japanese Kana Kanji input engine for IBus"
HOMEPAGE="https://github.com/ueno/ibus-kkc
	https://bitbucket.org/libkkc/libkkc"
EGIT_REPO_URI="https://github.com/ueno/ibus-kkc.git"
EGIT_BRANCH="master"

if [[ ${PV} != *9999* ]]; then
	EGIT_COMMIT="v${PV}"
fi

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND=">=app-i18n/ibus-1.5
	>=app-i18n/libkkc-0.3.4
	>=x11-libs/gtk+-3.10:3"
DEPEND="${COMMON_DEPEND}
	>=dev-lang/vala-0.10.0
	dev-libs/glib:2
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	app-i18n/libkkc-data
	app-i18n/skk-jisyo"

DOCS=( AUTHORS README )

src_prepare() {
	eautoreconf
	vala_src_prepare
}
