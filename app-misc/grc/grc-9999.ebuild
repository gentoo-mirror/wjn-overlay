# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5} pypy )

inherit python-r1

DESCRIPTION="Generic Colouriser beautifies your logfiles or output of commands"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/grc.html
	https://github.com/garabik/grc"

if [ ${PV} = 9999 ]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/garabik/grc.git"
else
	SRC_URI="https://github.com/garabik/grc/archive/v${PV}.tar.gz
		-> ${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${PYTHON_DEPS}"

PATCHES=(
	# https://github.com/garabik/grc/pull/19
	# This patch doesn't work for hostnames without any period
	# "${FILESDIR}"/${P}-domain-match.patch
)

src_install() {
	python_foreach_impl python_doscript grc grcat

	insinto /usr/share/grc
	doins conf.* grc.bashrc mrsmith/conf.*

	insinto /etc
	doins grc.conf

	dodoc CREDITS INSTALL README* Regexp.txt TODO debian/changelog
	doman grc.1 grcat.1
}