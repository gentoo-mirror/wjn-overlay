# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy python2_7 python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Easily import docs to your gh-pages branch"
HOMEPAGE="https://github.com/ionelmc/python-ghp-import
	https://pypi.python.org/pypi/ghp-import2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="tumbolia"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

DOCS=( CHANGELOG.rst CONTRIBUTING.rst README.rst )