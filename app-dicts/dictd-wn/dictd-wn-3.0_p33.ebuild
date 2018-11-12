# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

FORLANG="English"
TOLANG="English"

inherit freedict unpacker

MY_P="wn"

DESCRIPTION="WordNet for dict"
HOMEPAGE="https://wordnet.princeton.edu/"
SRC_URI="mirror://debian/pool/main/w/wordnet/dict-wn_${PV/_p/-}_all.deb"

LICENSE="Princeton"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"

DEPEND=">=app-text/dictd-1.5.5"

S="${WORKDIR}/usr/share/dictd"

src_unpack() {
	unpack_deb ${A}
}