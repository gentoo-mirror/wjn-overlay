# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools fdo-mime git-r3

DESCRIPTION="ObConf is a tool for configuring the Openbox window manager"
HOMEPAGE="http://openbox.org/wiki/ObConf:About"
EGIT_REPO_URI="git://git.openbox.org/dana/obconf.git"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.openbox.org/dana/${PN}.git"
else
	SRC_URI="http://openbox.org/dist/${PN}/${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls"

RDEPEND="
gnome-base/libglade:2.0
	x11-libs/gtk+:2
	x11-libs/startup-notification
	=x11-wm/openbox-9999
	"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	"

DOCS=( AUTHORS CHANGELOG README )

src_prepare() {
	eautopoint
	eautoreconf
}

src_configure() {
	econf $(use_enable nls)
}


pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

