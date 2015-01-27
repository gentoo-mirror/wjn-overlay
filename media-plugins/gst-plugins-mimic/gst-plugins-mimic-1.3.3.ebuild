# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

DESCRIPTION="GStreamer plugin for the MIMIC codec"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/libmimic-1.0.4[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

