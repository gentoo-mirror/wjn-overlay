# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="libsass command line driver"
HOMEPAGE="https://github.com/sass/sassc"
SRC_URI="https://github.com/sass/${PN}/archive/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

COMMON_DEPEND="~dev-libs/libsass-${PV}"
DEPEND=${COMMON_DEPEND}
RDEPEND=${COMMON_DEPEND}

RESTRICT="mirror"

src_prepare() {
	default
	eautoreconf
}
