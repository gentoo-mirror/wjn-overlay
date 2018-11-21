# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#  Though upstream's Original name is "acme.sh",
# period symbols are not allowed in package names
#  See https://devmanual.gentoo.org/ebuild-writing/file-format/index.html
MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An ACME protocol client written purely in Shell language"
HOMEPAGE="https://github.com/Neilpang/acme.sh"
SRC_URI="https://github.com/Neilpang/${MY_PN}/archive/${PV}.tar.gz
	-> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+cron idn"

DEPEND=""

# acme.sh is support POSIX shells, but Bash is preferred (and Gentoo has it)
RDEPEND="app-shell/bash
	|| ( dev-libs/openssl:0 dev-libs/libressl )
	|| ( net-misc/curl net-misc/wget )
	cron? ( virtual/cron )
	idn? ( net-dns/libidn )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# POSIX compatible shell is needed, C shells will fail
	sed -e 's:#!/usr/bin/env sh:#!/bin/bash --posix:' -i acme.sh
	eapply_user
}


src_install() {
	einstalldocs
	newdoc dnsapi/README.md README-dnsapi.md
	newdoc deploy/README.md README-deploy.md

	keepdir /etc/acme.sh
	newenvd "${FILESDIR}"/99acme.sh-env 99acme.sh

	exeinto /usr/share/acme.sh
	doexe acme.sh

	insinto /usr/share/acme.sh/dnsapi
	doins -r dnsapi/*.sh
	insinto /usr/share/acme.sh/deploy
	doins -r deploy/*.sh

	exeinto /usr/sbin
	newexe "${FILESDIR}"/acme.sh-sbin acme.sh

	if use cron ; then
		exeinto /etc/cron.daily
		newexe "${FILESDIR}"/acme.sh-cron acme.sh
	fi
}

pkg_postinst() {
	elog "Note:"
	elog " To use standalone mode, net-misc/socat has to be installed"
	elog " To use webroot mode, a web server must be run"
	elog " To use Apache mode or Nginx mode, be sure to install and run that"
	elog " Certificates can be obtained through DNS-01 challenge also."
	elog "if so, no web servers are needed"
}