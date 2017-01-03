# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils gnome2-utils xdg

DESCRIPTION="Fcitx (Flexible Context-aware Input Tool with eXtension) input method framework"
HOMEPAGE="https://fcitx-im.org/
	https://github.com/fcitx/fcitx"

if [[ "${PV}" == "9999" ]]; then
	PYTHON_COMPAT=( python3_{3,4} )
	inherit git-r3 python-r1
	EGIT_REPO_URI="https://github.com/fcitx/fcitx"
	SRC_URI=""
	LICENSE="GPL-2+ LGPL-2+ MIT"
	KEYWORDS=""
else
	SRC_URI="https://download.fcitx-im.org/fcitx/${P}_dict.tar.xz"
	LICENSE="GPL-2+ LGPL-2+"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
IUSE="+X +autostart +cairo +dbus debug +enchant gtk2 gtk3 +introspection lua nls opencc
	+pango qt4 qt5 static-libs +table test +xml"
REQUIRED_USE="autostart? ( dbus ) cairo? ( X ) gtk2? ( X dbus ) gtk3? ( X dbus )
	introspection? ( dbus ) pango? ( cairo ) qt4? ( X dbus ) qt5? ( X dbus )"

COMMON_DEPEND=">=x11-libs/libxkbcommon-0.5.0
	virtual/libiconv
	virtual/libintl
	X? ( x11-libs/libX11
		x11-libs/libXfixes
		x11-libs/libXinerama
		x11-libs/libXrender
		xml? ( x11-libs/libxkbfile ) )
	cairo? ( dev-libs/glib:2
		x11-libs/cairo[X]
		x11-libs/libXext
		pango? ( x11-libs/pango[X] )
		!pango? ( media-libs/fontconfig ) )
	dbus? ( sys-apps/dbus )
	enchant? ( app-text/enchant )
	gtk2? ( dev-libs/glib:2
		dev-libs/dbus-glib
		x11-libs/gtk+:2 )
	gtk3? ( dev-libs/glib:2
		dev-libs/dbus-glib
		x11-libs/gtk+:3 )
	introspection? ( dev-libs/glib:2
		dev-libs/gobject-introspection )
	lua? ( dev-lang/lua:= )
	nls? ( sys-devel/gettext )
	opencc? ( app-i18n/opencc )
	qt4? ( dev-qt/qtcore:4
		dev-qt/qtdbus:4
		dev-qt/qtgui:4[glib] )
	xml? ( app-text/iso-codes
		dev-libs/libxml2 )"
DEPEND="${COMMON_DEPEND}
	kde-frameworks/extra-cmake-modules:5
	virtual/pkgconfig"
RDEPEND=${COMMON_DEPEND}
	${PYTHON_DEPS}
PDEPEND="app-i18n/fcitx-qt5"

RESTRICT="mirror"

DOCS=( AUTHORS ChangeLog README THANKS TODO doc/API.txt doc/Develop_Readme doc/cjkvinput.txt
	doc/pinyin.txt )
HTML_DOCS=( doc/wb_fh.htm )

PATCHES=( "${FILESDIR}/${P}-tray_icon.patch"
	"${FILESDIR}/${P}-qt-4_ucs4.patch" )

src_prepare() {
	# https://github.com/fcitx/fcitx/issues/250
	sed \
		-e "/find_package(XkbFile REQUIRED)/i\\    if(ENABLE_X11)" \
		-e "/find_package(XkbFile REQUIRED)/s/^/    /" \
		-e "/find_package(XkbFile REQUIRED)/a\\    endif(ENABLE_X11)" \
		-i CMakeLists.txt

	cmake-utils_src_prepare

	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR="${EPREFIX}/usr/$(get_libdir)"
		-DSYSCONFDIR="${EPREFIX}/etc"
		-DENABLE_CAIRO=$(usex cairo)
		-DENABLE_DBUS=$(usex dbus)
		-DENABLE_DEBUG=$(usex debug)
		-DENABLE_ENCHANT=$(usex enchant)
		-DENABLE_GETTEXT=$(usex nls)
		-DENABLE_GIR=$(usex introspection)
		-DENABLE_GLIB2=$(if use cairo || use gtk2 || use gtk3 || use introspection
			then echo yes
			else echo no
			fi)
		-DENABLE_GTK2_IM_MODULE=$(usex gtk2)
		-DENABLE_GTK3_IM_MODULE=$(usex gtk3)
		-DENABLE_LIBXML2=$(usex xml)
		-DENABLE_LUA=$(usex lua)
		-DENABLE_OPENCC=$(usex opencc)
		-DENABLE_PANGO=$(usex pango)
		-DENABLE_QT=$(usex qt4)
		-DENABLE_QT_GUI=$(usex qt4)
		-DENABLE_QT_IM_MODULE=$(usex qt4)
		-DENABLE_SNOOPER=$(if use gtk2 || use gtk3
			then echo yes
			else echo no
			fi)
		-DENABLE_STATIC=$(usex static-libs)
		-DENABLE_TABLE=$(usex table)
		-DENABLE_TEST=$(usex test)
		-DENABLE_X11=$(usex X)
		-DENABLE_XDGAUTOSTART=$(usex autostart)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	rm -rf "${ED}/usr/share/doc/${PN}"
}

pkg_preinst() {
	gnome2_icon_savelist
	xdg_pkg_preinst
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_pkg_postinst
	use gtk2 && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_pkg_postrm
	use gtk2 && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
}
