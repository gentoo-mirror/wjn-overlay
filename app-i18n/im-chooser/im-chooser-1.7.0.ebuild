# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils

DESCRIPTION="Desktop Input Method configuration tool"
HOMEPAGE="https://pagure.io/im-chooser/"
SRC_URI="http://releases.pagure.org/im-chooser/${P}.tar.bz2"

LICENSE="GPL-2+ LGPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="xfce"

COMMON_DEPEND=">=app-i18n/imsettings-1.3.0
	>=dev-libs/glib-2.16.0:2
	|| ( >=x11-libs/gtk+-2.24:2
		>=x11-libs/gtk+-3.20:3 )
	x11-libs/libSM
	xfce? ( xfce-base/libxfce4util )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"
RDEPEND=${COMMON_DEPEND}

DOCS=( AUTHORS NEWS README )

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
