# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A tool makes web-browser reload automatically when web-contents rebuilt"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://github.com/lepture/python-livereload
    https://pypi.python.org/pypi/livereload"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="
		www-servers/tornado
"

DOCS="README.rst"

