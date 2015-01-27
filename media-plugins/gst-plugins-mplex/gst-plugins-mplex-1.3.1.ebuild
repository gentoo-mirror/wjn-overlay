# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

DESCRIPTION="GStreamer plugin for MPEG/DVD/SVCD/VCD video/audio multiplexing"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-video/mjpegtools-2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

