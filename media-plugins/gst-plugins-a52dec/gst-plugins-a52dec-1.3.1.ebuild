# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-ugly
inherit gstreamer

KEYWORDS=""
IUSE="+orc"

RDEPEND="
	>=media-libs/a52dec-0.7.3[${MULTILIB_USEDEP}]
	orc? ( >=dev-lang/orc-0.4.16[${MULTILIB_USEDEP}] )
"
DEPEND="${RDEPEND}"

