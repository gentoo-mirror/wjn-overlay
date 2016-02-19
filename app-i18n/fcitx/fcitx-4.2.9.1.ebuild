# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils gnome2-utils fdo-mime

DESCRIPTION="Flexible Contect-aware Input Tool with eXtension support"
HOMEPAGE="https://fcitx-im.org/"
SRC_URI="https://download.fcitx-im.org/fcitx/${P}_dict.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+X +autostart +cairo +dbus debug +enchant gtk gtk3 introspection lua nls
	opencc +pango qt4 qt5 static-libs +table test +xml"

REQUIRED_USE="cairo? ( X ) gtk? ( X ) gtk3? ( X ) qt4? ( X ) qt5? ( X )"

COMMON_DEPEND="
	>=x11-libs/libxkbcommon-0.5.0
	X? ( x11-libs/libX11
		x11-libs/libXinerama )
	cairo? ( x11-libs/cairo[X]
		pango? ( x11-libs/pango[X] )
		!pango? ( media-libs/fontconfig ) )
	dbus? ( sys-apps/dbus )
	enchant? ( app-text/enchant )
	gtk? ( x11-libs/gtk+:2
		dev-libs/glib:2
		dev-libs/dbus-glib )
	gtk3? ( x11-libs/gtk+:3
		dev-libs/glib:2
		dev-libs/dbus-glib )
	introspection? ( dev-libs/gobject-introspection )
	lua? ( dev-lang/lua:= )
	nls? ( sys-devel/gettext )
	opencc? ( app-i18n/opencc )
	qt4? ( dev-qt/qtcore:4
		dev-qt/qtdbus:4
		dev-qt/qtgui:4[glib] )
	xml? ( app-text/iso-codes
		dev-libs/libxml2
		x11-libs/libxkbfile )"
DEPEND="${COMMON_DEPEND}
	kde-frameworks/extra-cmake-modules
	virtual/libintl
	virtual/pkgconfig"
RDEPEND=${COMMON_DEPEND}
PDEPEND="app-i18n/fcitx-qt5"

RESTRICT="mirror"

DOCS=( AUTHORS ChangeLog README THANKS TODO doc/pinyin.txt doc/cjkvinput.txt
	doc/API.txt doc/Develop_Readme README.gentoo )
HTML_DOCS=( doc/wb_fh.htm )

src_prepare() {
	if use autostart ; then
		cat <<EOF >"${S}/README.gentoo"
You have enabled the "autostart" USE flag,
which will let 'fcitx' start automatically on XDG compatible desktop
environments, such as GNOME, KDE, LXDE, LXQt and Xfce.

If you use '~/.xinitrc' to configure your desktop,
make sure to include the 'fcitx' command to start it.
EOF
	fi

	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR=/usr/$(get_libdir)
		-DSYSCONFDIR=/etc/
		-DENABLE_X11="$(usex X)"
		-DENABLE_XDGAUTOSTART="$(usex autostart)"
		-DENABLE_CAIRO="$(usex cairo)"
		-DENABLE_DBUS="$(usex dbus)"
		-DENABLE_DEBUG="$(usex debug)"
		-DENABLE_ENCHANT="$(usex enchant)"
		-DENABLE_GTK2_IM_MODULE="$(usex gtk)"
		-DENABLE_SNOOPER="$(usex gtk)"
		-DENABLE_GTK3_IM_MODULE="$(usex gtk3)"
		-DENABLE_SNOOPER="$(usex gtk3)"
		-DENABLE_GIR="$(usex introspection)"
		-DENABLE_LUA="$(usex lua)"
		-DENABLE_GETTEXT="$(usex nls)"
		-DENABLE_OPENCC="$(usex opencc)"
		-DENABLE_PANGO="$(usex pango)"
		-DENABLE_QT="$(usex qt4)"
		-DENABLE_QT_IM_MODULE="$(usex qt4)"
		-DENABLE_QT_GUI="$(usex qt4)"
		-DENABLE_STATIC="$(usex static-libs)"
		-DENABLE_TABLE="$(usex table)"
		-DENABLE_TEST="$(usex test)"
		-DENABLE_LIBXML2="$(usex xml)")

	if use gtk || use gtk3 || use qt4 ; then
		mycmakeargs+=( -DENABLE_GLIB2=ON )
	fi

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	rm -rf "${ED}"/usr/share/doc/${PN} || die
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	use gtk && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	use gtk && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
}
