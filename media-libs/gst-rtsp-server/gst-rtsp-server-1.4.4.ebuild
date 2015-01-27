# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit python-r1

DESCRIPTION="A GStreamer based RTSP server"
HOMEPAGE="http://gstreamer.freedesktop.org/"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS=""
IUSE="debug doc +introspection nls static-libs vala"
#S="${WORKDIR}/${P/-server/}"

# ./configure is broken, so PYGOBJECT_REQ must be defined
#PYGOBJECT_REQ=2.11.2

RDEPEND="
	>=dev-libs/glib-2.10.0:2
	dev-libs/libxml2
	>=dev-python/pygobject-3:3[${PYTHON_USEDEP}]
	dev-python/gst-python:1.0
	introspection? ( >=dev-libs/gobject-introspection-0.6.3 )
	>=media-libs/gstreamer-1.4:1.0[introspection?]
	>=media-libs/gst-plugins-base-1.4:1.0[introspection?]
	vala? ( dev-lang/vala )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.3 )
	nls? ( >=sys-devel/gettext-0.17 )"

#pkg_setup() {
#	python_set_active_version 2
#}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable doc gtk-doc) \
		$(use_enable nls) \
		$(use_enable introspection) \
		$(use_enable static-libs static) \
		$(use_enable vala)
}
#		--with-package-origin="http://www.gentoo.org" \
#		PYGOBJECT_REQ=${PYGOBJECT_REQ} \

