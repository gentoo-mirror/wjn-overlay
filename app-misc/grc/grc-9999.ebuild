# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 pypy )

inherit eutils python-r1

DESCRIPTION="Generic Colouriser beautifies your logfiles or output of commands"
HOMEPAGE="http://kassiopeia.juls.savba.sk/~garabik/software/grc.html
	https://github.com/garabik/grc"

if [ ${PV} = 9999 ]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/garabik/grc.git"
else
	SRC_URI="http://kassiopeia.juls.savba.sk/~garabik/software/${PN}/${P/-/_}.orig.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${PYTHON_DEPS}"

RESTRICT="mirror"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.4-support-more-files.patch \
		"${FILESDIR}"/${PN}-1.4-ipv6.patch
}

src_install() {
	python_foreach_impl python_doscript grc grcat

	insinto /usr/share/grc
	doins conf.* "${FILESDIR}"/conf.*

	insinto /etc
	doins grc.conf

	dodoc README* INSTALL TODO debian/changelog CREDITS
	doman grc.1 grcat.1
}