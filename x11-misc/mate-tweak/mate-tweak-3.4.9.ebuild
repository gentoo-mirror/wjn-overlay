# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="MATE desktop tweak tool"
HOMEPAGE="https://launchpad.net/ubuntu/+source/mate-tweak"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}.orig.tar.gz"

REV="7de2c0b5ee5f"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="dev-libs/glib:2
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-misc/wmctrl"

S="${WORKDIR}/ubuntu-mate-${PN}-${REV}"