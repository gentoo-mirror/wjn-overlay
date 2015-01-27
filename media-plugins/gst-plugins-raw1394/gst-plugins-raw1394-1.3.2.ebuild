# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer plugin to capture firewire video"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=media-libs/libiec61883-1[${MULTILIB_USEDEP}]
	>=sys-libs/libraw1394-2[${MULTILIB_USEDEP}]
	sys-libs/libavc1394[${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}"

GST_PLUGINS_BUILD="dv1394"
GST_PLUGINS_BUILD_DIR="raw1394"

