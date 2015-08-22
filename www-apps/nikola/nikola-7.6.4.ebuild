# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
PYTHON_REQ_USE="gdbm"
inherit distutils-r1 python-r1

DESCRIPTION="A static website and blog generator"
HOMEPAGE="https://getnikola.com/"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/getnikola/${PN}.git"
	SRC_URI=""
else
	SRC_URI="https://github.com/getnikola/${PN}/archive/v${PV}.zip
		-> ${P}.zip"
fi

LICENSE="Gutenberg MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+assets bbcode charts -extras gh-pages hyphenation ipython jinja +markdown micawber php typogrify websocket"
REQUIRED_USE="extras? ( assets bbcode charts gh-pages hyphenation ipython jinja markdown micawber php typogrify websocket )"
# mock, coverage, pytest, pytest-cov, freezegun, python-coveralls and colorama
# are necessary for test.
RESTRICT="test"

DEPEND=">=dev-python/docutils-0.12[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/blinker-1.3[${PYTHON_USEDEP}]
	~dev-python/doit-0.28.0[${PYTHON_USEDEP}]
	>=dev-python/logbook-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.3.5[${PYTHON_USEDEP}]
	>=dev-python/mako-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/natsort-3.5.2[${PYTHON_USEDEP}]
	>=dev-python/pillow-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-1.6[${PYTHON_USEDEP}]
	>=dev-python/PyRSS2Gen-1.1[${PYTHON_USEDEP}]
	~dev-python/python-dateutil-2.4.2[${PYTHON_USEDEP}]
	>=dev-python/pytz-2013d[${PYTHON_USEDEP}]
	>=dev-python/requests-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/setuptools-5.4.1[${PYTHON_USEDEP}]
	>=dev-python/unidecode-0.04.16[${PYTHON_USEDEP}]
	~dev-python/watchdog-0.8.3[${PYTHON_USEDEP}]
	~dev-python/yapsy-1.11.223[${PYTHON_USEDEP}]
	assets? ( >=dev-python/webassets-0.10.1[${PYTHON_USEDEP}] )
	bbcode? ( dev-python/bbcode[${PYTHON_USEDEP}] )
	charts? ( ~dev-python/pygal-2.0.1[${PYTHON_USEDEP}] )
	gh-pages? ( >=dev-python/ghp-import-0.4.1[${PYTHON_USEDEP}] )
	hyphenation? ( >=dev-python/pyphen-0.9.1[${PYTHON_USEDEP}] )
	ipython? ( >=dev-python/ipython-2.0.0[${PYTHON_USEDEP},notebook] )
	jinja? ( >=dev-python/jinja-2.7.2[${PYTHON_USEDEP}] )
	markdown? ( >=dev-python/markdown-2.4.0[${PYTHON_USEDEP}] )
	micawber? ( >=dev-python/micawber-0.3.0[${PYTHON_USEDEP}] )
	php? ( >=dev-python/phpserialize-1.3[${PYTHON_USEDEP}] )
	typogrify? ( >=dev-python/typogrify-2.0.4[${PYTHON_USEDEP}] )
	websocket? ( ~dev-python/ws4py-0.3.4 )"

src_install() {
	distutils-r1_src_install

	# hackish way to remove docs that ended up in the wrong place
	rm -rf "${D}"/usr/share/doc/${PN}

	dodoc AUTHORS.txt CHANGES.txt README.rst docs/*.txt
	doman docs/man/nikola.1.gz
}
