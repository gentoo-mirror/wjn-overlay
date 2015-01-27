# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer encoder/decoder for JPEG format"
KEYWORDS=""
IUSE=""

RDEPEND="virtual/jpeg[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

