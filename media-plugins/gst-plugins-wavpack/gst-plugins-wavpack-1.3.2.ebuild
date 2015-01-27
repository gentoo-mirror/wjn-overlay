# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer encoder/decoder for wavpack audio format"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-sound/wavpack-4.40[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

