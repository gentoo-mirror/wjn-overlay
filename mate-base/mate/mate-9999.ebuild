# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit multilib

DESCRIPTION="Meta ebuild for MATE, a traditional desktop environment"
HOMEPAGE="http://mate-desktop.org/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS=""
IUSE="+base -bluetooth +themes +extras"

RDEPEND="~mate-base/mate-desktop-9999:0
	~mate-base/mate-menus-9999:0
	~mate-base/mate-panel-9999:0
	~mate-base/mate-session-manager-9999:0
	~mate-base/mate-settings-daemon-9999:0
	~x11-misc/mate-notification-daemon-9999:0
	~x11-wm/marco-9999:0
	base? ( ~mate-base/caja-9999:0
		~mate-base/mate-applets-9999:0
		~mate-base/mate-control-center-9999:0
		~mate-extra/mate-media-9999:0
		~x11-terms/mate-terminal-9999:0 )
	bluetooth? ( net-wireless/blueman:0 )
	themes? ( ~x11-themes/mate-backgrounds-9999:0
		~x11-themes/mate-icon-theme-9999:0
		~x11-themes/mate-icon-theme-faenza-9999:0
		~x11-themes/mate-themes-9999:0 )
	extras? ( ~app-arch/engrampa-9999:0
		~app-editors/pluma-9999:0
		~app-text/atril-9999:0
		~mate-extra/mate-power-manager-9999:0
		~mate-extra/mate-screensaver-9999:0
		~mate-extra/mate-system-monitor-9999:0
		~mate-extra/mate-utils-9999:0
		~media-gfx/eom-9999:0 )"
PDEPEND="virtual/notification-daemon:0"

S="${WORKDIR}"

pkg_postinst() {
	elog "For installation, usage and troubleshooting details regarding MATE;"
	elog "read more about it at Gentoo Wiki: https://wiki.gentoo.org/wiki/MATE"
	elog ""
	elog "MATE 1.8 had some packages renamed, replaced and/or dropped; for more"
	elog "details, see http://mate-desktop.org/blog/2014-03-04-mate-1-8-released"
	elog ""
	elog "MATE 1.6 has moved from mateconf to gsettings. This means that the"
	elog "desktop settings and panel applets will return to their default."
	elog "You will have to reconfigure your desktop appearance."
	elog ""
	elog "There is mate-conf-import that converts from mateconf to gsettings."
	elog ""
	elog "For support with mate-conf-import see the following MATE forum topic:"
	elog "http://forums.mate-desktop.org/viewtopic.php?f=16&t=1650"
}
