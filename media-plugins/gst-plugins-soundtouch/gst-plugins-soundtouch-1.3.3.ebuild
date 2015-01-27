# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

DESCRIPTION="GStreamer elements for beats-per-minute detection and pitch controlling"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/libsoundtouch-1.4[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

