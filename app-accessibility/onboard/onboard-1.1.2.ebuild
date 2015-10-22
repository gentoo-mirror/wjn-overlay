# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{3,4,5} )

inherit distutils-r1 gnome2-utils versionator

DESCRIPTION="An onscreen keyboard useful for tablet PC users and for mobility impaired users"
HOMEPAGE="https://launchpad.net/onboard"
SRC_URI="https://launchpad.net/onboard/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DOCS=( AUTHORS NEWS README )

COMMON_DEPEND="dev-libs/dbus-glib
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	dev-util/intltool
	gnome-base/dconf
	gnome-base/gsettings-desktop-schemas
	gnome-base/librsvg
	media-libs/libcanberra
	sys-apps/dbus
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[introspection]
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXtst
	x11-libs/libwnck:3
	x11-libs/pango"
RDEPEND="${COMMON_DEPEND}
	app-text/hunspell
	app-text/iso-codes
	gnome-extra/mousetweaks"

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
