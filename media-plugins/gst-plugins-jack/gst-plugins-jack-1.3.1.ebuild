# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

GST_ORG_MODULE=gst-plugins-good
inherit gstreamer

DESCRIPION="GStreamer source/sink to transfer audio data with JACK ports"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-sound/jack-audio-connection-kit-0.99.10[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"

