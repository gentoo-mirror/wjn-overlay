# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="A static website and blog generator"
HOMEPAGE="http://getnikola.com/"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/getnikola/${PN}.git"
	SRC_URI=""
else
	SRC_URI="https://github.com/getnikola/${PN}/archive/v${PV}.zip
		-> ${P}.zip"
fi

LICENSE="MIT-with-advertising Apache-2.0" # Gutenberg
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+assets bbcode charts -extras hyphenation ipython jinja livereload +markdown micawber mock php typogrify"
REQUIRED_USE="extras? ( assets bbcode charts hyphenation ipython jinja livereload markdown micawber mock php typogrify )"
RESTRICT="test"

DEPEND="dev-python/docutils[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/blinker-1.3[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	>=dev-python/doit-0.23.0[${PYTHON_USEDEP}]
	>=dev-python/logbook-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.3.5[${PYTHON_USEDEP}]
	>=dev-python/mako-1.0[${PYTHON_USEDEP}]
	>=dev-python/natsort-3.3.0[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/pygments-1.6[${PYTHON_USEDEP}]
	>=dev-python/PyRSS2Gen-1.1[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.4.1[${PYTHON_USEDEP}]
	>=dev-python/pytz-2013d[${PYTHON_USEDEP}]
	>=dev-python/requests-1.0[${PYTHON_USEDEP}]
	>=dev-python/setuptools-5.4.1[${PYTHON_USEDEP}]
	>=dev-python/unidecode-0.04.16[${PYTHON_USEDEP}]
	>=dev-python/yapsy-1.10.423[${PYTHON_USEDEP}]
	virtual/python-imaging[${PYTHON_USEDEP}]
	assets? ( >=dev-python/webassets-0.10.1[${PYTHON_USEDEP}] )
	bbcode? ( dev-python/bbcode[${PYTHON_USEDEP}] )
	charts? ( >=dev-python/pygal-1.5.1[${PYTHON_USEDEP}] )
	hyphenation? ( >=dev-python/pyphen-0.9.1[${PYTHON_USEDEP}] )
	ipython? ( >=dev-python/ipython-1.2.1[${PYTHON_USEDEP}] )
	jinja? ( >=dev-python/jinja-2.7.2[${PYTHON_USEDEP}] )
	livereload? ( dev-python/livereload[${PYTHON_USEDEP}] )
	markdown? ( >=dev-python/markdown-2.4.0[${PYTHON_USEDEP}] )
	micawber? ( >=dev-python/micawber-0.3.0[${PYTHON_USEDEP}] )
	mock? ( >=dev-python/mock-1.0.0[${PYTHON_USEDEP}] )
	php? ( dev-python/phpserialize[${PYTHON_USEDEP}] )
	typogrify? ( >=dev-python/typogrify-2.0.4[${PYTHON_USEDEP}] )
	"

src_install() {
	distutils-r1_src_install

	# hackish way to remove docs that ended up in the wrong place
	rm -rf "${D}"/usr/share/doc/${PN}

	dodoc AUTHORS.txt CHANGES.txt README.rst docs/*.txt
	doman docs/man/*
}

