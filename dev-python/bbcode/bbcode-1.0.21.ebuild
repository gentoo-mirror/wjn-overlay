# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A pure python bbcode parser and formatter"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://github.com/dcwatson/bbcode
	https://pypi.python.org/pypi/bbcode"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS="README.md"