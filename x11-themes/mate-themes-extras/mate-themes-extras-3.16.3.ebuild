# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools git-r3 versionator

DESCRIPTION="GTK2/3 desktop themes for MATE"
HOMEPAGE="https://github.com/raveit65/mate-themes-extras"
SRC_URI=""
EGIT_REPO_URI="https://github.com/raveit65/${PN}.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS=""

FOR_GTK=$(get_version_component_range 1-2)
COMMON_DEPEND=">=x11-libs/gdk-pixbuf-2.0.0:2
	|| ( >=x11-libs/gtk+-${FOR_GTK}.0:3
		( >=x11-libs/gtk+-2.0.0:2
			>=x11-themes/gtk-engines-2.15.3:2 
			x11-themes/murrine-themes:0 ) )"
DEPEND=${COMMON_DEPEND}
# adwaita: DeLorean*, GnomishBeige
# dmz: DeLorean*
RDEPEND="${COMMON_DEPEND}
	x11-themes/adwaita-icon-theme
	x11-themes/mate-themes
	x11-themes/mate-icon-theme
	x11-themes/vanilla-dmz-aa-xcursors"

RESTRICT="binchecks mirrorstrip"

DOCS=( AUTHORS ChangeLog NEWS README )

pkg_pretend() {
	if has_version x11-libs/gtk+:3 \
		&& ! has_version =x11-libs/gtk+-"${FOR_GTK}"* ; then
		ewarn "Since ${P} is for gtk+-${FOR_GTK},"
		ewarn "it isn't adjusted for your $(best_version x11-libs/gtk+)."
	fi
}

src_prepare() {
	sed -i -e 's/DMZ-Black/Vanilla-DMZ-AA/g' \
		desktop-themes/DeLorean*/index.theme || die
	eautoreconf
}

# *Submarine is in mate-themes
src_configure() {
	econf --disable-Blue-Submarine \
		--enable-DeLorean \
		--enable-DeLorean-Dark \
		--disable-Green-Submarine \
		--enable-GnomishBeige
}