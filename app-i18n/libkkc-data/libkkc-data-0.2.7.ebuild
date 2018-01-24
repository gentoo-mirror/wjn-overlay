# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="Japanese Kana Kanji conversion dictionary for libkkc"
HOMEPAGE="https://github.com/ueno/libkkc
	https://bitbucket.org/libkkc/libkkc"
SRC_URI="https://bitbucket.org/libkkc/${PN}/downloads/${P}.tar.xz"

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