# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer plugin for HTTP client sources"

KEYWORDS=""
IUSE=""

RDEPEND=">=net-libs/libsoup-2.38[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

