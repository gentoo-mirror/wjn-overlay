# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit distutils-r1 versionator

MPV=$(get_version_component_range 1-2)

DESCRIPTION="LightDM Gtk+ Greeter settings editor"
HOMEPAGE="https://launchpad.net/lightdm-gtk-greeter-settings"
SRC_URI="https://launchpad.net/${PN}/${MPV}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"

DEPEND=">=dev-python/python-distutils-extra-2.18[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+
	x11-libs/pango
	>=x11-misc/lightdm-gtk-greeter-2.0.0"