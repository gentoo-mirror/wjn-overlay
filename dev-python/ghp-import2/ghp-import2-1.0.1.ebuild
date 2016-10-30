# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( pypy python{2_7,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Easily import docs to your gh-pages branch"
HOMEPAGE="https://github.com/ionelmc/python-ghp-import"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="tumbolia"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

DOCS=( CHANGELOG.rst CONTRIBUTING.rst README.rst )