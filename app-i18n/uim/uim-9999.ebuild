# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools elisp-common gnome2-utils qmake-utils

DESCRIPTION="Simple, secure and flexible input method library"
HOMEPAGE="https://github.com/uim/uim"
if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/uim/uim.git"
	EGIT_BRANCH="master"
	EGIT_CHECKOUT_DIR="${S}"
else
	SRC_URI="https://github.com/uim/uim/releases/download/${P}/${P}.tar.bz2"
fi

LICENSE="BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="X +anthy canna curl eb emacs expat gtk gtk3 kde libedit libffi libnotify
	m17n-lib ncurses nls qt3support qt4 qt5 skk sqlite ssl static-libs
	unicode xft"
REQUIRED_USE="gtk? ( X )
	qt4? ( X )
	qt5? ( X )"

RESTRICT="test"

COMMON_DEPEND="!dev-scheme/sigscheme
	X? ( x11-libs/libX11
		x11-libs/libXft
		x11-libs/libXt
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXext
		x11-libs/libXrender )
	anthy? ( unicode? ( >=app-i18n/anthy-8622 )
		!unicode? ( app-i18n/anthy ) )
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
	ncurses? ( sys-libs/ncurses:0 )
	nls? ( virtual/libintl )
	qt3support? ( dev-qt/qtgui:4[qt3support] )
	qt4? ( dev-qt/qtgui:4 )
	qt5? ( dev-qt/qtgui:5
		dev-qt/qtx11extras:5 )
	skk? ( app-i18n/skk-jisyo )
	sqlite? ( dev-db/sqlite:3 )
	ssl? ( || ( dev-libs/openssl:*
		dev-libs/libressl ) )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	>=sys-devel/gettext-0.15
	virtual/pkgconfig
	X? ( x11-base/xorg-proto )
	kde? ( dev-util/cmake )"
if [[ ${PV} = *9999* ]]; then
	DEPEND="${DEPEND}
		app-text/asciidoc
		dev-lang/perl
		dev-lang/ruby
		>=dev-util/intltool-0.35.2
		gnome-base/librsvg
		>=sys-devel/autoconf-2.61
		>=sys-devel/automake-1.10
		>=sys-devel/libtool-1.5.22"
fi
RDEPEND=${COMMON_DEPEND}

DOCS=( AUTHORS ChangeLog.old ChangeLog.old.2 NEWS README RELNOTE )

SITEFILE=50${PN}-gentoo.el

src_prepare() {
	eapply \
		"${FILESDIR}"/${PN}-1.6.0-gentoo.patch \
		"${FILESDIR}"/${PN}-1.5.4-zhTW.patch

	# bug 275420
	sed -i -e "s:\$libedit_path/lib:/$(get_libdir):g" configure.ac \
		|| die 'sed configure.ac failed!'

	# plugin file must be installed to sandbox
	if use qt4 ; then
		sed -i \
			-e 's_target.path.*/_target.path += '"/$(qt4_get_plugindir)"'/_g' \
			qt4/immodule/quiminputcontextplugin.pro.in \
			|| die 'sed qt4/immodule/ failed!'
	fi

	# plugin file must be installed to sandbox
	if use qt5 ; then
		sed -i \
			-e 's_target.path.*/_target.path += '"/$(qt5_get_plugindir)"'/_g' \
			qt5/immodule/quimplatforminputcontextplugin.pro.in \
			|| die 'sed qt5/immodule/ failed!'
	fi

	if [[ ${PV} = *9999* ]]; then
		( cd sigscheme/libgcroots
			_elibtoolize --force --copy
			eaclocal -I m4
			eautomake
			eautoconf
		 )
		( cd sigscheme
			eaclocal -I m4
			_elibtoolize --force --copy
			eautoheader
			eautomake
			eautoconf
		)
		eaclocal -I m4
		_elibtoolize --force --copy
		eautoheader
		eautomake
		eautoconf
		intltoolize --copy --force --automake
		sed -i -e "s/^DISTFILES/# Makevars gets inserted here. (Don't remove this line!)\n\nDISTFILES/" \
			po/Makefile.in.in || die 'sed Makefile.in.in failed!'
	else
		AT_NO_RECURSIVE=1 eautoreconf
	fi
	eapply_user
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

	if use gtk3 ; then
		myconf="${myconf} --enable-default-toolkit=gtk3"
	elif use qt5 ; then
		myconf="${myconf} --enable-default-toolkit=qt5"
	elif use qt4 ; then
		myconf="${myconf} --enable-default-toolkit=qt4"
	elif use gtk ; then
		myconf="${myconf} --enable-default-toolkit=gtk"
	fi

	use qt4 && export QMAKE4="$(qt4_get_bindir)/qmake"
	use qt5 && export QMAKE5="$(qt5_get_bindir)/qmake"

	# This is neccessary to run "PKG_CHECK_MODULES" correctly around econf
	if has_version dev-util/pkgconf[pkg-config] ; then
		export PKG_CONFIG="/usr/bin/pkgconf"
	fi

	econf --disable-gnome-applet \
		--disable-gnome3-applet \
		--disable-kde-applet \
		--enable-maintainer-mode \
		--without-osx-dcs \
		--without-qt \
		--without-qt-immodule \
		--disable-warnings-into-error \
		${myconf} \
		$(use_with X x) \
		$(use_with canna) \
		$(use_with curl) \
		$(use_with eb) \
		$(use_enable emacs) \
		$(use_with emacs lispdir "${SITELISP}") \
		$(use_with expat) \
		$(use_with gtk gtk2) \
		$(use_with gtk3) \
		$(use_with gtk3 gtk-immodule) \
		$(use_enable kde kde4-applet) \
		$(use_with libedit) \
		$(use_with libffi ffi) \
		$(use_enable libnotify notify libnotify) \
		$(use_with m17n-lib m17nlib) \
		$(use_enable ncurses fep) \
		$(use_enable nls) \
		$(use_enable qt3support qt4-qt3support) \
  		$(use_with qt4 qt4) \
		$(use_with qt4 qt4-immodule) \
		$(use_enable qt5) \
		$(use_with qt5 qt5) \
		$(use_with qt5 qt5-immodule) \
		$(use_with skk) \
		$(use_with sqlite sqlite3) \
		$(use_enable ssl openssl) \
		$(use_enable static-libs static) \
		$(use_with xft)
}

src_compile() {
	default

	if use emacs; then
		( cd emacs && elisp-compile *.el ) || die "elisp-compile failed!"
	fi
}

src_install() {
	emake -j1 INSTALL_ROOT="${D}" DESTDIR="${D}" install

	einstalldocs

	if use emacs; then
		elisp-install uim-el emacs/*.elc || die "elisp-install failed!"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" uim-el \
			|| die "elisp-site-file-install failed!"
	fi

	find "${ED}/usr/$(get_libdir)/uim" -name '*.la' -exec rm {} +
	use static-libs || find "${ED}" -name '*.la' -exec rm {} +

	sed -e "s:@EPREFIX@:${EPREFIX}:" "${FILESDIR}/xinput-uim" >"${T}/uim.conf" \
		|| die "sed uim.conf failed!"
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
	elog "uim-im-switcher-gtk3, uim-im-switcher-qt4 or uim-im-switcher-qt5."
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
