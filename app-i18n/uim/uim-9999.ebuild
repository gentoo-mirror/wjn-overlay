# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit autotools base eutils multilib elisp-common gnome2-utils qmake-utils

SSCM_VER="0.8.5"

DESCRIPTION="Simple, secure and flexible input method library"
HOMEPAGE="http://code.google.com/p/uim/"
if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/uim/uim.git"
	EGIT_BRANCH="master"
	EGIT_CHECKOUT_DIR=${S}
	SRC_URI="https://uim.googlecode.com/files/${PN}-1.8.6.tar.gz
	https://sigscheme.googlecode.com/files/sigscheme-${SSCM_VER}.tar.gz"
else
	SRC_URI="http://uim.googlecode.com/files/${P}.tar.bz2"
fi

LICENSE="BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="+anthy canna curl eb emacs expat gtk gtk3 kde libedit libffi libnotify
	m17n-lib ncurses nls qt4 qt5 skk sqlite ssl static-libs unicode X xft
	linguas_zh_CN linguas_zh_TW linguas_ja linguas_ko"

RESTRICT="test"

COMMON_DEPEND="X? (
		x11-libs/libX11
		x11-libs/libXft
		x11-libs/libXt
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXext
		x11-libs/libXrender
	)
	anthy? (
		unicode? ( >=app-i18n/anthy-8622 )
		!unicode? ( app-i18n/anthy )
	)
	canna? ( app-i18n/canna )
	curl? ( >=net-misc/curl-7.16.4 )
	eb? ( dev-libs/eb )
	emacs? ( virtual/emacs )
	expat? ( dev-libs/expat )
	gtk? ( >=x11-libs/gtk+-2.4:2 )
	gtk3? ( x11-libs/gtk+:3 )
	kde? ( >=kde-base/kdelibs-4 )
	libedit? ( dev-libs/libedit )
	libffi? ( virtual/libffi )
	libnotify? ( >=x11-libs/libnotify-0.4 )
	m17n-lib? ( >=dev-libs/m17n-lib-1.3.1 )
	ncurses? ( sys-libs/ncurses )
	nls? ( virtual/libintl )
	qt4? ( dev-qt/qtgui:4[qt3support] )
	qt5? ( dev-qt/qtgui:5 )
	skk? ( app-i18n/skk-jisyo )
	sqlite? ( dev-db/sqlite:3 )
	ssl? ( dev-libs/openssl:* )
	!dev-scheme/sigscheme"
DEPEND="${COMMON_DEPEND}
	app-text/asciidoc
	dev-lang/perl
	dev-lang/ruby
	dev-util/intltool
	gnome-base/librsvg
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	virtual/pkgconfig
	>=sys-devel/gettext-0.15
	kde? ( dev-util/cmake )
	X? (
		x11-proto/xextproto
		x11-proto/xproto
	)"
RDEPEND="${COMMON_DEPEND}
	X? (
		media-fonts/font-sony-misc
		linguas_zh_CN? (
			|| ( media-fonts/font-isas-misc media-fonts/intlfonts )
		)
		linguas_zh_TW? (
			media-fonts/intlfonts
		)
		linguas_ja? (
			|| ( media-fonts/font-jis-misc media-fonts/intlfonts )
		)
		linguas_ko? (
			|| ( media-fonts/font-daewoo-misc media-fonts/intlfonts )
		)
	)"

SITEFILE=50${PN}-gentoo.el

pkg_setup() {
	strip-linguas fr ja ko
	if [[ -z "${LINGUAS}" ]]; then
		# no linguas set, using the default one
		LINGUAS=" "
	fi
}

src_unpack() {
	git-r3_checkout
	unpack ${A}
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.6.0-gentoo.patch \
		"${FILESDIR}"/${PN}-1.5.4-zhTW.patch

	# bug 275420
	sed -i -e "s:\$libedit_path/lib:/$(get_libdir):g" configure.ac || die "sed failed!"

	AT_NO_RECURSIVE=1 eautoreconf

	cp -Rn "${WORKDIR}/${PN}-1.8.6/pixmaps" "${S}/"

	rm -rf "${S}/sigscheme"
	mv "${WORKDIR}/sigscheme-${SSCM_VER}" "${S}/sigscheme"
}

src_configure() {
	local myconf

	if (use gtk || use gtk3) && (use anthy || use canna) ; then
		myconf="${myconf} --enable-dict"
	else
		myconf="${myconf} --disable-dict"
	fi

	if use gtk || use gtk3 || use qt4 ; then
		myconf="${myconf} --enable-pref"
	else
		myconf="${myconf} --disable-pref"
	fi

	if use anthy ; then
		if use unicode ; then
			myconf="${myconf} --with-anthy-utf8"
		else
			myconf="${myconf} --with-anthy"
		fi
	else
		myconf="${myconf} --without-anthy"
	fi

	if use libnotify ; then
		myconf="${myconf} --enable-notify=libnotify"
	fi

	if use qt4 ; then
		export QT4DIR="/usr/$(get_libdir)/qt4"
		export QMAKE4="/usr/bin/qmake"
	fi

	if use qt5 ; then
		export PATH="/usr/$(get_libdir)/qt5/bin:${PATH}"
		export QT5DIR="/usr/$(get_libdir)/qt5"
		export QMAKE5="/usr/$(get_libdir)/qt5/bin/qmake"
	fi

	addwrite "/usr/plugins"

	if [[ ${PV} = *9999* ]]; then
		cd "${S}/sigscheme/libgcroots"
		cd "${S}/sigscheme" && ./autogen.sh
		cd "${S}" && ./autogen.sh
	fi

	econf $(use_with X x) \
		$(use_with canna) \
		$(use_with curl) \
		$(use_with eb) \
		$(use_enable emacs) \
		$(use_with emacs lispdir "${SITELISP}") \
		$(use_with expat) \
		$(use_with libffi ffi) \
		--disable-gnome-applet \
		$(use_with gtk gtk2) \
		$(use_with gtk3) \
		$(use_with gtk3 gtk-immodule) \
		$(use_with libedit) \
		--disable-kde-applet \
		$(use_enable kde kde4-applet) \
		$(use_with m17n-lib m17nlib) \
		$(use_enable ncurses fep) \
		$(use_enable nls) \
		--without-qt \
		--without-qt-immodule \
  		$(use_with qt4 qt4) \
		$(use_with qt4 qt4-immodule) \
		$(use_enable qt4 qt4-qt3support) \
		$(use_enable qt5) \
		$(use_with qt5 qt5) \
		$(use_with qt5 qt5-immodule) \
		$(use_with skk) \
		$(use_with sqlite sqlite3) \
		$(use_enable ssl openssl) \
		$(use_enable static-libs static) \
		$(use_with xft) \
		${myconf}

	if use qt4 ; then
		sed -i 's:/usr/plugins:/usr/'$(get_libdir)'/qt4/plugins:g' "${S}"/qt4/immodule/*
		cd "${S}/qt4/candwin"
		"${QMAKE4}" -makefile -o Makefile.qmake uim-candwin-qt4.pro
		cd "${S}/qt4/chardict"
		"${QMAKE4}" -makefile -o Makefile.qmake uim-chardict-qt4.pro
		cd "${S}/qt4/edittest"
		"${QMAKE4}" -makefile -o Makefile.qmake edittest.pro
		cd "${S}/qt4/immodule"
		"${QMAKE4}" -makefile -o Makefile.qmake quiminputcontextplugin.pro
		cd "${S}/qt4/pref"
		"${QMAKE4}" -makefile -o Makefile.qmake uim-pref-qt4.pro
		cd "${S}/qt4/switcher"
		"${QMAKE4}" -makefile -o Makefile.qmake uim-im-switcher-qt4.pro
		cd "${S}/qt4/toolbar"
		"${QMAKE4}" -makefile -o Makefile.qmake uim-toolbar-qt4.pro
		cd "${S}/qt4"
		"${QMAKE4}" -makefile -o Makefile.qmake common.pro
		cd "${S}"
	fi

	if use qt5 ; then
		sed -i 's:/usr/plugins:/usr/'$(get_libdir)'/qt5/plugins:g' "${S}"/qt5/immodule/*
		cd "${S}/qt5/candwin"
		"${QMAKE5}" -makefile -o Makefile.qmake uim-candwin-qt4.pro
		cd "${S}/qt5/chardict"
		"${QMAKE5}" -makefile -o Makefile.qmake uim-chardict-qt4.pro
		cd "${S}/qt5/edittest"
		"${QMAKE5}" -makefile -o Makefile.qmake edittest.pro
		cd "${S}/qt5/immodule"
		"${QMAKE5}" -makefile -o Makefile.qmake quiminputcontextplugin.pro
		cd "${S}/qt5/pref"
		"${QMAKE5}" -makefile -o Makefile.qmake uim-pref-qt4.pro
		cd "${S}/qt5/switcher"
		"${QMAKE5}" -makefile -o Makefile.qmake uim-im-switcher-qt4.pro
		cd "${S}/qt5/toolbar"
		"${QMAKE5}" -makefile -o Makefile.qmake uim-toolbar-qt4.pro
		cd "${S}/qt5"
		"${QMAKE5}" -makefile -o Makefile.qmake common.pro
		cd "${S}"
	fi

}

src_compile() {
	base_src_compile "$@"

	if use emacs; then
		cd emacs
		elisp-compile *.el || die "elisp-compile failed!"
	fi
}

src_install() {
	base_src_install -j1 INSTALL_ROOT="${D}" "$@"

	dodoc AUTHORS ChangeLog* NEWS README RELNOTE
	if use emacs; then
		elisp-install uim-el emacs/*.elc || die "elisp-install failed!"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" uim-el \
			|| die "elisp-site-file-install failed!"
	fi

	find "${ED}/usr/$(get_libdir)/uim" -name '*.la' -exec rm {} +
	use static-libs || find "${ED}" -name '*.la' -exec rm {} +

	sed -e "s:@EPREFIX@:${EPREFIX}:" "${FILESDIR}/xinput-uim" > "${T}/uim.conf" || die "sed failed!"
	insinto /etc/X11/xinit/xinput.d
	doins "${T}/uim.conf"
}

pkg_postinst() {
	elog
	elog "New input method switcher has been introduced. You need to set"
	elog
	elog "% GTK_IM_MODULE=uim ; export GTK_IM_MODULE"
	elog "% QT_IM_MODULE=uim ; export QT_IM_MODULE"
	elog "% XMODIFIERS=@im=uim ; export XMODIFIERS"
	elog
	elog "If you would like to use uim-anthy as default input method, put"
	elog "(define default-im-name 'anthy)"
	elog "to your ~/.uim."
	elog
	elog "All input methods can be found by running uim-im-switcher-gtk, "
	elog "uim-im-switcher-gtk3 or uim-im-switcher-qt4."
	elog
	elog "If you upgrade from a version of uim older than 1.4.0,"
	elog "you should run revdep-rebuild."

	use gtk && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
	if use emacs; then
		elisp-site-regen
		echo
		elog "uim is autoloaded with Emacs with a minimal set of features:"
		elog "There is no keybinding defined to call it directly, so please"
		elog "create one yourself and choose an input method."
		elog "Integration with LEIM is not done with this ebuild, please have"
		elog "a look at the documentation how to achieve this."
	fi
}

pkg_postrm() {
	use gtk && gnome2_query_immodules_gtk2
	use gtk3 && gnome2_query_immodules_gtk3
	use emacs && elisp-site-regen
}
