# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Filters to enhance web typography, including support for Django & Jinja templates"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://github.com/mintchaos/typogrify
	https://pypi.python.org/pypi/typogrify/"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS="README.rst"
