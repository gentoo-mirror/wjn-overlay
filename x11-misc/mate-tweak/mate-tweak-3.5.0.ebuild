# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="MATE desktop tweak tool"
HOMEPAGE="https://launchpad.net/ubuntu/+source/mate-tweak"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}.orig.tar.gz"

REV="37bc921efe90"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="nls"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	nls? ( sys-devel/gettext ) "

RDEPEND="dev-libs/glib:2
	gnome-base/dconf
	mate-base/caja
	mate-base/mate-panel
	mate-extra/mate-media
	sys-process/psmisc
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-misc/wmctrl"

S="${WORKDIR}/ubuntu-mate-${PN}-${REV}"