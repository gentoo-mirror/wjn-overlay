# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

DESCRIPTION="GStreamer plugin for MPEG-1/2 video encoding"
KEYWORDS=""
IUSE="+orc"

RDEPEND="
	media-libs/libdca[${MULTILIB_USEDEP}]
	orc? ( >=dev-lang/orc-0.4.16[${MULTILIB_USEDEP}] )
"
DEPEND="${RDEPEND}"

