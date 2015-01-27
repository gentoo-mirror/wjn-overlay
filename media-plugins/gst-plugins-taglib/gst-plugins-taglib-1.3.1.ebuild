# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPTION="GStreamer taglib based tag handler"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/taglib-1.5[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

