# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils gnome2-utils

DESCRIPTION="Japanese Anthy module for Fcitx"
HOMEPAGE="http://fcitx-im.org/"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 ~x86"

COMMON_DEPEND=">=app-i18n/fcitx-4.2.8
	app-i18n/anthy"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	virtual/libintl"
RDEPEND=${COMMON_DEPEND}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
