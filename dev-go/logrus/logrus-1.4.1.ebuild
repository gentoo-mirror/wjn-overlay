# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/sirupsen/logrus

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="structured logger for Go, API compatible with the standard library logger"
HOMEPAGE="https://github.com/sirupsen/logrus"
LICENSE="MIT"
SLOT="0/${PVR}"

DEPEND=">=dev-go/go-sys-0_pre20180816:=
	>=dev-go/go-windows-terminal-sequences-1.0.1:=
	>=dev-go/testify-1.2.2:="
RDEPEND=""

RESTRICT="mirror strip"

DOCS=( CHANGELOG.md README.md )

src_install() {
	golang-build_src_install

	pushd "src/${EGO_PN}" >/dev/null || die
	einstalldocs
	popd >/dev/null || die
}
