# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A python SVG charts generator"
HOMEPAGE="http://pygal.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS=""

DEPEND="${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${PYTHON_DEPS}
	dev-python/lxml[${PYTHON_USEDEP}]
	media-gfx/cairosvg[${PYTHON_USEDEP}]"

RESTRICT="mirror"
