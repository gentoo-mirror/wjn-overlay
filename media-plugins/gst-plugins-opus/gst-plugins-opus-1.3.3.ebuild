# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

DESCRIPTION="GStreamer plugin for Opus audio codec support"
KEYWORDS=""
IUSE=""

COMMON_DEPEND=">=media-libs/opus-0.9.4:=[${MULTILIB_USEDEP}]"
RDEPEND="${COMMON_DEPEND}
	media-libs/gst-plugins-base:${SLOT}[${MULTILIB_USEDEP},ogg]"
DEPEND="${COMMON_DEPEND}"

