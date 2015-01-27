# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils flag-o-matic multilib-minimal

MY_PN="gst-libav"
DESCRIPTION="FFmpeg based gstreamer plugin"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/gst-libav.html"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_PN}-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="1.0"
KEYWORDS=""
IUSE="+orc"

RDEPEND="
	>=media-libs/gstreamer-1.3.2:1.0[${MULTILIB_USEDEP}]
	>=media-libs/gst-plugins-base-1.3.2:1.0[${MULTILIB_USEDEP}]
	>=virtual/ffmpeg-9[${MULTILIB_USEDEP}]
	orc? ( >=dev-lang/orc-0.4.16[${MULTILIB_USEDEP}] )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.12
	virtual/pkgconfig[${MULTILIB_USEDEP}]
"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	sed -e 's/sleep 15//' -i configure.ac configure || die

	# compatibility with recent releases 
	# TODO: likely apply them with libav-10 when it's out but there will
	# probably be an upstream gst-libav release compatible at that time.
	if has_version '>=media-video/libav-10' ; then
		sed -i -e 's/ CODEC_ID/ AV_CODEC_ID/g' \
			   -e 's/ CodecID/ AVCodecID/g' \
			   -e 's/r_frame_rate/avg_frame_rate/g' \
			   -e 's/ case AV_CODEC_ID_SNOW:/ /g' \
			   ext/libav/*.{c,h} || die
	fi
}

multilib_src_configure() {
	GST_PLUGINS_BUILD=""
	# always use system ffmpeg/libav if possible
	ECONF_SOURCE=${S} \
	econf \
		--disable-maintainer-mode \
		--with-package-name="Gentoo GStreamer ebuild" \
		--with-package-origin="http://www.gentoo.org" \
		--disable-fatal-warnings \
		--with-system-libav \
		$(use_enable orc)
}

multilib_src_compile() {
	# Don't build with -Werror
	emake ERROR_CFLAGS=
}

multilib_src_install_all() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	einstalldocs
	prune_libtool_files --modules
}

pkg_postinst() {
	if has_version "media-video/ffmpeg"; then
		elog "Please note that upstream uses media-video/libav"
		elog "rather than media-video/ffmpeg. If you encounter any"
		elog "issues try to move from ffmpeg to libav."
	fi
}

