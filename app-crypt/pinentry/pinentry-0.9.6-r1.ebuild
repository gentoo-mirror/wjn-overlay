# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools qmake-utils multilib eutils flag-o-matic toolchain-funcs

DESCRIPTION="Collection of simple PIN or passphrase entry dialogs which utilize the Assuan protocol"
HOMEPAGE="http://gnupg.org/aegypten2/index.html"
SRC_URI="mirror://gnupg/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="caps emacs gnome-keyring gtk2 gtk3 libsecret ncurses qt4 qt5 static"

COMMON_DEPEND="app-crypt/gcr
	app-eselect/eselect-pinentry
	>=dev-libs/libgpg-error-1.17
	>=dev-libs/libassuan-2
	caps? ( sys-libs/libcap )
	gtk2? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	ncurses? ( sys-libs/ncurses:0= )
	qt4? ( >=dev-qt/qtgui-4.4.1:4 )
	qt5? ( dev-qt/qtgui:5
		dev-qt/qtwidgets:5 )
	static? ( >=sys-libs/ncurses-5.7-r5:0=[static-libs,-gpm] )"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	libsecret? ( app-crypt/libsecret )"
RDEPEND=${COMMON_DEPEND}
REQUIRED_USE="|| ( ncurses gtk2 gtk3 qt4 qt5 )
	gnome-keyring ( gtk3 !static )
	gtk2? ( !static )
	gtk3? ( gnome-keyring !static )
	qt4? ( !qt5 !static )
	qt5? ( !static )
	static? ( ncurses )"

DOCS=( AUTHORS ChangeLog NEWS README THANKS TODO )

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.8.2-ncurses.patch"
	use qt4 && epatch "${FILESDIR}/${P}-qt4.diff"
	eautoreconf
}

src_configure() {
	use static && append-ldflags -static
	[[ "$(gcc-major-version)" -ge 5 ]] && append-cxxflags -std=gnu++11

	econf \
		--enable-pinentry-tty \
		$(use_with caps libcap) \
		$(use_enable emacs pinentry-emacs) \
		$(use_enable gtk2 pinentry-gtk2) \
		$(use_enable gtk3 pinentry-gnome3) \
		$(use_enable libsecret) \
		$(use_enable ncurses pinentry-curses) \
		$(use_enable ncurses fallback-curses) \
		$(usex qt4 '--enable-pinentry-qt') \
		$(usex qt5 '--enable-pinentry-qt')
}

src_install() {
	default
	rm -f "${ED}"/usr/bin/pinentry || die
}

pkg_postinst() {
	if ! has_version 'app-crypt/pinentry' || has_version '<app-crypt/pinentry-0.7.3'; then
		elog "We no longer install pinentry-curses and pinentry-qt SUID root by default."
		elog "Linux kernels >=2.6.9 support memory locking for unprivileged processes."
		elog "The soft resource limit for memory locking specifies the limit an"
		elog "unprivileged process may lock into memory. You can also use POSIX"
		elog "capabilities to allow pinentry to lock memory. To do so activate the caps"
		elog "USE flag and add the CAP_IPC_LOCK capability to the permitted set of"
		elog "your users."
	fi
	eselect pinentry update ifunset
}

pkg_postrm() {
	eselect pinentry update ifunset
}
