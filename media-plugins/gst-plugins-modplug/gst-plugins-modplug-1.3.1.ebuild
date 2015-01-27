# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-bad
inherit gstreamer

KEYWORDS=""
IUSE=""

RDEPEND="media-libs/libmodplug[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

