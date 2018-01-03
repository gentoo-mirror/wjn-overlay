# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Filters to enhance web typography, often used with Jinja or Django"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://github.com/mintchaos/typogrify
	https://pypi.python.org/pypi/typogrify/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND=${PYTHON_DEPS}
RDEPEND=${PYTHON_DEPS}

RESTRICT="mirror"

DOCS="README.rst"
