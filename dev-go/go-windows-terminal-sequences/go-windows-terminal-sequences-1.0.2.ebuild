# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/konsorten/go-windows-terminal-sequences

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Enable support for Windows Terminal Colors for Go"
HOMEPAGE="https://github.com/konsorten/go-windows-terminal-sequences"
LICENSE="MIT"
SLOT="0/${PVR}"

DEPEND=""
RDEPEND=""

RESTRICT="mirror strip"

src_install() {
	golang-build_src_install

	pushd "src/${EGO_PN}" >/dev/null || die
	einstalldocs
	popd >/dev/null || die
}
