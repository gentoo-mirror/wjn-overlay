# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="Japanese Kana Kanji conversion dictionary for libkkc"
HOMEPAGE="https://github.com/ueno/libkkc"
SRC_URI="https://github.com/ueno/libkkc/releases/download/v0.3.5/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="${PYTHON_DEPS}
	app-i18n/libkkc"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

RESTRICT="mirror"

pkg_setup() {
	python-single-r1_pkg_setup
}
