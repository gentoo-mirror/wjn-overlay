# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/stretchr/objx

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Go package for dealing with maps, slices, JSON and other data"
HOMEPAGE="https://github.com/stretchr/objx"
LICENSE="MIT"
SLOT="0/${PVR}"

DEPEND=""
RDEPEND="dev-go/go-difflib
	dev-go/go-spew"
PDEPEND="dev-go/testify"

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
