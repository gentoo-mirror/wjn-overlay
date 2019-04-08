# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_SRC=github.com/davecgh/${PN}
EGO_PN=${EGO_SRC}/...

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	SRC_URI="https://${EGO_SRC}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Implements a deep pretty printer for Go data structures to aid in debugging"
HOMEPAGE="https://github.com/davecgh/go-spew"
LICENSE="ISC"
SLOT="0/${PV}"

DEPEND=""
RDEPEND=""

RESTRICT="mirror strip"

src_install() {
	golang-build_src_install

	pushd "src/${EGO_SRC}" >/dev/null || die
	einstalldocs
	popd >/dev/null || die
}