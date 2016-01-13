# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{3,4} )
# It doesn't seem to be compatible with Python 3.5 still yet.
# PYTHON_COMPAT=( python3_{3,4,5} )

inherit distutils-r1

REV="998ebdda6538"
DESCRIPTION="MATE desktop tweak tool"
HOMEPAGE="https://launchpad.net/ubuntu/+source/mate-tweak"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}.orig.tar.gz"

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
	x11-libs/gtk+:2"

S="${WORKDIR}/ubuntu-mate-${PN}-${REV}"
RESTRICT="mirror"