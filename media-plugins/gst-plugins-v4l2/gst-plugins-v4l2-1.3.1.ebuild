# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPION="plugin to allow capture from video4linux2 devices"
KEYWORDS=""
IUSE="udev"

RDEPEND="
	media-libs/libv4l[${MULTILIB_USEDEP}]
	media-libs/gst-plugins-base:1.0[X,${MULTILIB_USEDEP}]
	udev? ( >=virtual/libgudev-143 )
"
DEPEND="${RDEPEND}
	virtual/os-headers"

GST_PLUGINS_BUILD="gst_v4l2"

multilib_src_configure() {
	gstreamer_multilib_src_configure \
		--with-libv4l2 \
		$(use_with udev gudev)
}
