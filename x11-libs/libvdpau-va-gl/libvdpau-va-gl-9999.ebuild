# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils git-r3

DESCRIPTION="VDPAU driver with OpenGL/VAAPI backend"
HOMEPAGE="https://github.com/i-rinat/libvdpau-va-gl"
EGIT_REPO_URI="https://github.com/i-rinat/${PN}.git"
EGIT_BRANCH="master"

KEYWORDS=""
LICENSE="LGPL-3"
SLOT="0"

DEPEND="x11-libs/libvdpau
		x11-libs/libva
		>=dev-libs/glib-2.0
		media-libs/mesa"
RDEPEND="${DEPEND}"

src_install() {
	cmake-utils_src_install
	dodoc README.md
	echo 'VDPAU_DRIVER=va_gl' > 61libvdpau-va-gl
	doenvd 61libvdpau-va-gl
}