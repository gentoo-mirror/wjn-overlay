# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit python-single-r1

DESCRIPTION="Japanese Kana Kanji conversion dictionary for libkkc"
HOMEPAGE="https://github.com/ueno/libkkc"
SRC_URI="https://github.com/ueno/libkkc/releases/download/v0.3.5/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="${PYTHON_DEPS}
	app-i18n/libkkc
	$(python_gen_cond_dep '
		dev-libs/marisa[python,${PYTHON_USEDEP}]
	')
	"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

PATCHES=( "${FILESDIR}/${P}-enable-python3.patch" )

RESTRICT="mirror"

pkg_setup() {
	python-single-r1_pkg_setup
}