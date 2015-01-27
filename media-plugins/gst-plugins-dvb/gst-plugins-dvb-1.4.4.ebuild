# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

DESCRIPION="GStreamer plugin to allow capture from dvb devices"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="virtual/os-headers"

multilib_src_compile() {
	# Prepare generated headers
	emake -C gst-libs/gst/mpegts

	gstreamer_multilib_src_compile
}

