# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

KEYWORDS=""
IUSE=""

RDEPEND="
	>=media-libs/libdvdnav-4.1.2[${MULTILIB_USEDEP}]
	>=media-libs/libdvdread-4.1.2[${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}"

