# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils

DESCRIPTION="Scalable and PNG icon theme named Dropline Neu!"
HOMEPAGE="https://www.gnome-look.org/p/1108733/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

DEPEND=""
RDEPEND="!minimal? ( x11-themes/adwaita-icon-theme )"

S="${WORKDIR}"
RESTRICT="binchecks strip"

src_unpack() {
	unpack "${FILESDIR}/Neu-${PV}-PR3.tar.bz2"
}

src_install() {
	dodoc Neu/{AUTHORS,README}
	rm -f Neu/{AUTHORS,COPYING,DONATE,INSTALL,README,TODO}

	insinto /usr/share/icons
	doins -r Neu || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
