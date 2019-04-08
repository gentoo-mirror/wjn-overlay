# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/stretchr/testify

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Toolkit for testifying that your code will behave as you intend"
HOMEPAGE="https://github.com/stretchr/testify"
LICENSE="MIT"
SLOT="0/${PVR}"

DEPEND=">=dev-go/go-difflib-1.0.0:=
	>=dev-go/go-spew-1.1.0:=
	>=dev-go/objx-0.1.0:="
RDEPEND=""

RESTRICT="mirror strip"

src_prepare() {
	eapply_user
	rm -rf src/${EGO_PN}/vendor
}

src_install() {
	golang-build_src_install

	pushd "src/${EGO_PN}" >/dev/null || die
	einstalldocs
	popd >/dev/null || die
}
