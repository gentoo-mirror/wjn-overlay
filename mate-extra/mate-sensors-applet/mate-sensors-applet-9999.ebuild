# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools git-r3 gnome2

DESCRIPTION="MATE panel applet to display readings from hardware sensors"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+dbus -gtk3 hddtemp libnotify lm_sensors
	video_cards_fglrx video_cards_nvidia"

COMMON_DEPEND="app-text/rarian:0
	dev-libs/glib:2
	~mate-base/mate-panel-9999:0[gtk3?]
	>=x11-libs/cairo-1.0.4:0
	x11-libs/gdk-pixbuf:2
	virtual/libintl:0
	!gtk3? ( >=x11-libs/gtk+-2.24.0:2 )
	gtk3? ( >=x11-libs/gtk+-3.0.0:3 )
	hddtemp? ( dbus? ( >=dev-libs/dbus-glib-0.80:0
			>=dev-libs/libatasmart-0.16:0 )
		!dbus? ( >=app-admin/hddtemp-0.3_beta13:0 ) )
	libnotify? ( >=x11-libs/libnotify-0.7:0 )
	lm_sensors? ( sys-apps/lm_sensors:0 )
	video_cards_fglrx? ( x11-drivers/ati-drivers:1 )
	video_cards_nvidia? ( || ( >=x11-drivers/nvidia-drivers-100.14.09:0
		media-video/nvidia-settings:0 ) )"
DEPEND="${COMMON_DEPEND}
	>=app-text/scrollkeeper-dtd-1:1.0
	app-text/yelp-tools:0
	dev-util/intltool:0
	sys-devel/gettext:0
	virtual/pkgconfig:0"
RDEPEND="${COMMON_DEPEND}"

# Requires libxslt only for use by gnome-doc-utils.
PDEPEND="hddtemp? ( dbus? ( sys-fs/udisks:0 ) )"

DOCS=( AUTHORS NEWS README TODO )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	local myconf

	if use hddtemp && use dbus; then
		myconf="${myconf} $(use_enable dbus udisks)"
	else
		myconf="${myconf} --disable-udisks"
	fi

	gnome2_src_configure \
		--disable-static \
		--with-gtk=$(usex gtk3 '3.0' '2.0') \
		$(use_enable libnotify) \
		$(use_with lm_sensors libsensors) \
		$(use_with video_cards_fglrx aticonfig) \
		$(use_with video_cards_nvidia nvidia) \
		${myconf}
}
