# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-ugly
inherit gstreamer

KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/libsidplay-1.3:1[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

