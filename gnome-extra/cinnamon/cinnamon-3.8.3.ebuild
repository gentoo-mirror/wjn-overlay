# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python{3_4,3_5,3_6} )
PYTHON_REQ_USE="xml"

inherit autotools eutils flag-o-matic gnome2 multilib pax-utils python-r1

DESCRIPTION="A fork of GNOME Shell with layout similar to GNOME 2"
HOMEPAGE="http://developer.linuxmint.com/"

MY_PV="${PV/_p/-UP}"
MY_P="${PN}-${MY_PV}"

SRC_URI="https://github.com/linuxmint/Cinnamon/archive/${MY_PV}.tar.gz
	-> ${MY_P}.tar.gz"
LICENSE="GPL-2+"
SLOT="0"

IUSE="+nls +networkmanager"

REQUIRED_USE=${PYTHON_REQUIRED_USE}

KEYWORDS=""

COMMON_DEPEND="${PYTHON_DEPS}
	app-accessibility/at-spi2-atk:2
	app-misc/ca-certificates
	dev-libs/dbus-glib
	>=dev-libs/glib-2.35.0:2[dbus]
	>=dev-libs/gobject-introspection-0.10.1:=
	>=dev-libs/json-glib-0.13.2
	>=dev-libs/libcroco-0.6.2:0.6
	dev-libs/libxml2:2
	gnome-base/librsvg
	>=gnome-extra/cinnamon-desktop-2.4:0=[introspection]
	>=gnome-extra/cinnamon-menus-3.0[introspection]
	>=gnome-extra/cjs-3.2.0
	>=media-libs/clutter-1.10:1.0[introspection]
	media-libs/cogl:1.0=[introspection]
	>=gnome-base/gsettings-desktop-schemas-2.91.91
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	net-libs/libsoup:2.4[introspection]
	>=sys-auth/polkit-0.100[introspection]
	x11-libs/gdk-pixbuf:2[introspection]
	>=x11-libs/gtk+-3.12.0:3[introspection]
	x11-libs/pango[introspection]
	>=x11-libs/startup-notification-0.11
	x11-libs/libX11
	>=x11-libs/libXfixes-5.0
	>=x11-wm/muffin-3.5.0[introspection]
	networkmanager? ( gnome-base/libgnome-keyring
		>=net-misc/networkmanager-0.8.999:=[introspection] )"

DEPEND="${COMMON_DEPEND}
	!!=dev-lang/spidermonkey-1.8.2*
	dev-python/polib[${PYTHON_USEDEP}]
	dev-util/gtk-doc
	>=dev-util/intltool-0.4
	gnome-base/gnome-common
	>=sys-devel/gettext-0.17
	virtual/pkgconfig"
# libmozjs.so is picked up from /usr/lib while compiling, so block at build-time
# https://bugs.gentoo.org/show_bug.cgi?id=360413

# Runtime-only deps are probably incomplete and approximate.
# Each block:
# 2. Introspection stuff + dconf needed via imports.gi.*
# 3. gnome-session is needed for gnome-session-quit
# 4. Control shell settings
# 5. accountsservice is needed for GdmUserManager (0.6.14 needed for fast
#    user switching with gdm-3.1.x)
# 6. caribou needed for on-screen keyboard
# 7. xdg-utils needed for xdg-open, used by extension tool
# 8. imaging, lxml needed for cinnamon-settings
# 9. gnome-icon-theme-symbolic needed for various icons
# 10. pygobject needed for menu editor
# 11. nemo - default file manager, tightly integrated with cinnamon
RDEPEND="${COMMON_DEPEND}
	>=app-accessibility/caribou-0.3
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pexpect[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	dev-python/pypam[${PYTHON_USEDEP}]
	>=gnome-base/dconf-0.4.1
	>=gnome-base/libgnomekbd-2.91.4[introspection]
	>=gnome-extra/cinnamon-control-center-2.4
	>=gnome-extra/cinnamon-screensaver-2.4
	>=gnome-extra/cinnamon-session-3.6
	>=gnome-extra/cinnamon-settings-daemon-3.6
	>=gnome-extra/nemo-2.4
	>=sys-apps/accountsservice-0.6.14[introspection]
	|| ( sys-power/upower[introspection]
		sys-power/upower-pm-utils[introspection] )
	x11-libs/xapps[introspection]
	x11-misc/xdg-utils
	x11-themes/adwaita-icon-theme
	x11-themes/gnome-themes-standard
	networkmanager? ( gnome-extra/nm-applet
		net-misc/mobile-broadband-provider-info
		sys-libs/timezone-data )
	nls? ( >=gnome-extra/cinnamon-translations-2.4 )"

S="${WORKDIR}/Cinnamon-${PV}"
RESTRICT="mirror"

pkg_setup() {
	python_setup
}

src_prepare() {
	# Fix backgrounds path as cinnamon doesn't provide them
	# https://github.com/linuxmint/Cinnamon/issues/3575
	sed -i -e 's:usr/share/cinnamon-background:usr/share/gnome-background:' \
		files/usr/share/cinnamon/cinnamon-settings/modules/cs_backgrounds.py \
		|| die

	# Use wheel group instead of sudo (from Fedora/Arch)
	# https://github.com/linuxmint/Cinnamon/issues/3576
	eapply "${FILESDIR}"/${PN}-3.6.6-wheel-sudo.patch

	if ! use networkmanager; then
		rm -rv files/usr/share/cinnamon/applets/network@cinnamon.org || die
		sed -i -e 's/nm-applet;//' \
			files/usr/share/cinnamon-session/sessions/cinnamon*.session || die
		sed -i -e 's/'nm-applet': 'network',//' \
			js/ui/statusIconDispatcher.js || die
	fi

	# A needless file still includes one python2 shebang
	rm -rf docs/search-providers-examples/chromium-history@cinnamon.org || die
	python_fix_shebang "${S}"

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--libdir="${EPREFIX}/usr/$(get_libdir)" \
		--with-ca-certificates="${EPREFIX}/etc/ssl/certs/ca-certificates.crt" \
		BROWSER_PLUGIN_DIR="${EPREFIX}/usr/$(get_libdir)/nsbrowser/plugins"
}

src_install() {
	gnome2_src_install
	python_optimize "${ED}"usr/$(get_libdir)/cinnamon-*

	# Required for gnome-shell on hardened/PaX, bug #398941
	pax-mark mr "${ED}usr/bin/cinnamon"

	# Doesn't exist on Gentoo, causing this to be a dead symlink
	rm -f "${ED}etc/xdg/menus/cinnamon-applications-merged" || die

	# Ensure authentication-agent is started, bug #523958
	# https://github.com/linuxmint/Cinnamon/issues/3579
	insinto /etc/xdg/autostart/
	doins "${FILESDIR}"/polkit-cinnamon-authentication-agent-1.desktop
}

pkg_postinst() {
	gnome2_pkg_postinst

	if ! has_version 'media-libs/gst-plugins-good:1.0' || \
	   ! has_version 'media-plugins/gst-plugins-vpx:1.0'; then
		ewarn "To make use of Cinnamon's built-in screen recording utility,"
		ewarn "you need to either install media-libs/gst-plugins-good:1.0"
		ewarn "and media-plugins/gst-plugins-vpx:1.0, or use dconf-editor to change"
		ewarn "org.cinnamon.recorder/pipeline to what you want to use."
	fi
}