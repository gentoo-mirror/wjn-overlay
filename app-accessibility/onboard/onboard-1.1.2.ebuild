# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{3,4,5} )

inherit distutils-r1 gnome2-utils versionator

DESCRIPTION="Onscreen keyboard for tablet PC users and mobility impaired users"
HOMEPAGE="https://launchpad.net/onboard"
SRC_URI="https://launchpad.net/${PN}/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

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
	app-accessibility/at-spi2-core
	app-text/hunspell
	app-text/iso-codes
	gnome-extra/mousetweaks
	x11-libs/libxkbfile"

RESTRICT="mirror"

# These are using a functionality of distutils-r1.eclass
DOCS=( AUTHORS CHANGELOG NEWS README
	onboard-defaults.conf.example onboard-defaults.conf.example.nexus7 )
HTML_DOCS=( docs/. )
PATCHES=( "${FILESDIR}/${PN}-remove-duplicated-docs.patch" )

src_prepare() {
	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install

	# Delete duplicated docs installed by original dustutils
	rm "${D}"/usr/share/doc/onboard/*
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
