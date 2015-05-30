# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlterm/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="bidi cairo debug fcitx gtk ibus libssh2 m17n-lib nls pixbuf regis scim static-libs uim utempter xft"
REQUIRED_USE="pixbuf? ( gtk )"

RDEPEND="
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	bidi? ( dev-libs/fribidi )
	cairo? ( x11-libs/cairo )
	fcitx? ( app-i18n/fcitx )
	gtk? ( x11-libs/gtk+:2 )
	ibus? ( app-i18n/ibus )
	libssh2? ( net-libs/libssh2 )
	m17n-lib? ( dev-libs/m17n-lib )
	nls? ( virtual/libintl )
	pixbuf? ( x11-libs/gdk-pixbuf:2 )
	regis? (
		|| (
			media-libs/sdl-ttf
			media-libs/sdl2-ttf
		)
	)
	scim? ( app-i18n/scim )
	uim? ( app-i18n/uim )
	utempter? ( sys-libs/libutempter )
	xft? ( x11-libs/libXft )
	"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	"

DOCS=( ChangeLog README )

src_prepare() {
	# default config
	sed -i \
		-e "/ icon_path =/aicon_path = ${EPREFIX}/usr/share/pixmaps/mlterm-icon.svg" \
		-e "/ scrollbar_view_name =/ascrollbar_view_name = sample" \
		etc/main
}

src_configure() {
	addpredict /dev/ptmx

	local scrollbars="sample,extra"
	local tools="mlclient,mlcc,mlmenu,mlterm-zoom"
	use gtk && tools+=",mlconfig,mlterm-menu"
	use pixbuf && scrollbars=+",pixmap_engine"
	use regis && tools+=",registobmp"

	econf \
		--enable-optimize-redrawing \
		--enable-vt52 \
		$(use_enable bidi fribidi) \
		$(use_enable debug) \
		$(use_enable fcitx) \
		$(use_enable ibus) \
		$(use_enable libssh2 ssh2) \
		$(use_enable m17n-lib m17nlib) \
		$(use_enable nls) \
		$(use_enable scim) \
		$(use_enable uim) \
		$(use_enable utempter utmp) \
		$(use_with gtk gtk 2.0) \
		$(usex pixbuf "--with-imagelib=gdk-pixbuf" "") \
		--with-scrollbars=${scrollbars} \
		--with-tools=${tools} \
		--with-type-engines=xcore$(usex xft ",xft" "")$(usex cairo ",cairo" "")
}

src_install () {
	default

	dodoc -r doc/en
	dodoc -r doc/ja
	
	docinto contrib/icon
	dodoc contrib/icon/README

	doicon contrib/icon/mlterm*
	make_desktop_entry mlterm mlterm mlterm-icon "System;TerminalEmulator"
}

