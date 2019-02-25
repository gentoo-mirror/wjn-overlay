# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5,3_6} )
PYTHON_REQ_USE="gdbm"

inherit distutils-r1 python-r1

DESCRIPTION="A static website and blog generator"
HOMEPAGE="https://getnikola.com/
	https://pypi.python.org/pypi/Nikola"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/getnikola/${PN}.git"
	SRC_URI=""
else
	SRC_URI="https://github.com/getnikola/${PN}/archive/v${PV}.tar.gz
		-> ${P}.tar.gz"
fi

# CC0-1.0: nikola/data/samplesite/pages/dr-nikolas-vendetta.rst
LICENSE="CC0-1.0 MIT"
SLOT="0"
KEYWORDS=""
IUSE="bbcode charts ghpages hyphenation ipython jinja micawber php toml typogrify
	watchdog websocket yaml"

COMMON_DEPEND=">=dev-python/Babel-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.13[${PYTHON_USEDEP}]
	>=dev-python/setuptools-24.2.0[${PYTHON_USEDEP}]"
DEPEND=${COMMON_DEPEND}
RDEPEND="${COMMON_DEPEND}
	>=dev-python/blinker-1.3[${PYTHON_USEDEP}]
	>=dev-python/doit-0.28.0[${PYTHON_USEDEP}]
	>=dev-python/logbook-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.3.5[${PYTHON_USEDEP}]
	>=dev-python/mako-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/markdown-2.4.0[${PYTHON_USEDEP}]
	<dev-python/markdown-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/natsort-3.5.2[${PYTHON_USEDEP}]
	>=dev-python/piexif-1.0.3[${PYTHON_USEDEP}]
	>=dev-python/pillow-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-1.6[${PYTHON_USEDEP}]
	>=dev-python/PyRSS2Gen-1.1[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/unidecode-0.04.16[${PYTHON_USEDEP}]
	>=dev-python/yapsy-1.11.223[${PYTHON_USEDEP}]
	bbcode? ( dev-python/bbcode[${PYTHON_USEDEP}] )
	charts? ( >=dev-python/pygal-2.0.0[${PYTHON_USEDEP}] )
	ghpages? ( || ( >=dev-python/ghp-import-0.4.1-r1[${PYTHON_USEDEP}]
		>=dev-python/ghp-import2-1.0.0[${PYTHON_USEDEP}] ) )
	hyphenation? ( >=dev-python/pyphen-0.9.1[${PYTHON_USEDEP}] )
	ipython? ( >=dev-python/ipykernel-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/notebook-4.0.0[${PYTHON_USEDEP}] )
	jinja? ( >=dev-python/jinja-2.7.2[${PYTHON_USEDEP}] )
	micawber? ( >=dev-python/micawber-0.3.0[${PYTHON_USEDEP}] )
	php? ( >=dev-python/phpserialize-1.3[${PYTHON_USEDEP}] )
	toml? ( >=dev-python/toml-0.9.2[${PYTHON_USEDEP}] )
	typogrify? ( >=dev-python/typogrify-2.0.4[${PYTHON_USEDEP}] )
	watchdog? ( >=dev-python/watchdog-0.8.3[${PYTHON_USEDEP}] )
	websocket? ( >=dev-python/aiohttp-2.3.8[${PYTHON_USEDEP}] )
	yaml? ( >=dev-python/ruamel-yaml-0.15[${PYTHON_USEDEP}] )"

# >=dev-python/coverage-4.5.1 is neccessary for test.
RESTRICT="mirror test"

src_prepare() {
	# Upstream's doit>=0.30.1 is to block Python 2. But this ebuild is not targeting Python 2.
	sed -i -e '/doit/s/>=0.30.1/>=0.28.0/' requirements.txt

	# QA: Manuals should not be zipped.
	unpack docs/man/nikola.1.gz

	default
}

src_install() {
	distutils-r1_src_install

	# hackish way to remove docs that ended up in the wrong place
	rm -rf "${D}/usr/share/doc/${PN}"

	# Do not gzip the manual
	rm "${D}/usr/share/man/man1/nikola.1.gz"

	dodoc {AUTHORS,CHANGES}.txt CODE_OF_CONDUCT.md {CONTRIBUTING,README}.rst \
		docs/{manual,theming,extending}.rst
	doman nikola.1
}

pkg_postinst() {
	elog "Since Nikola version 8, few manual changes are required to upgrade"
	elog "See https://getnikola.com/blog/upgrading-to-nikola-v8.html"
}
