# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

XORG_DRI=dri
inherit linux-info xorg-2

COMMIT_ID="b48d4a7917ab793526be47559becc64aacd347ae"
DESCRIPTION="X.Org driver for Intel cards"
SRC_URI="http://cgit.freedesktop.org/xorg/driver/xf86-video-intel/snapshot/${COMMIT_ID}.tar.xz -> ${P}.tar.xz"

KEYWORDS="~amd64"
IUSE="debug -dri3 +sna +udev uxa xvmc"
# dri3 will freeze under uxa
REQUIRED_USE=" || ( sna uxa )
	dri3? ( dri sna !uxa )"

COMMON_DEPEND=">=x11-proto/dri2proto-2.6
	x11-proto/dri3proto
	x11-proto/presentproto
	x11-proto/resourceproto"
DEPEND=${COMMON_DEPEND}
RDEPEND="${COMMON_DEPEND}
	x11-libs/libXext
	x11-libs/libXfixes
	>=x11-libs/libdrm-2.4.29[video_cards_intel]
	>=x11-libs/pixman-0.27.1
	sna? ( >=x11-base/xorg-server-1.10 )
	udev? ( virtual/udev )
	xvmc? ( x11-libs/libXvMC
		>=x11-libs/libxcb-1.5
		x11-libs/xcb-util )"

S=${WORKDIR}/${COMMIT_ID}

src_prepare() {
	eautoreconf
}

src_configure() {
	# For enabling dri3, dri2 must be disabled
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable debug)
		$(use_enable dri)
		$(use_enable dri3)
		$(usex dri3 --disable-dri2 --enable-dri2 "" "")
		$(use_enable sna)
		$(use_enable uxa)
		$(use_enable udev)
		$(use_enable xvmc)
	)
	xorg-2_src_configure
}

pkg_postinst() {
	if linux_config_exists \
		&& ! linux_chkconfig_present DRM_I915_KMS; then
		echo
		ewarn "This driver requires KMS support in your kernel"
		ewarn "  Device Drivers --->"
		ewarn "    Graphics support --->"
		ewarn "      Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)  --->"
		ewarn "      <*>   Intel 830M, 845G, 852GM, 855GM, 865G (i915 driver)  --->"
		ewarn "	      i915 driver"
		ewarn "      [*]       Enable modesetting on intel by default"
		echo
	fi
}