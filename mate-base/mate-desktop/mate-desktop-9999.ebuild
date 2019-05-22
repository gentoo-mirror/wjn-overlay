# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

GNOME2_LA_PUNT="yes"

inherit git-r3 meson

DESCRIPTION="Library with common API for various MATE modules"
HOMEPAGE="http://mate-desktop.org/
	https://github.com/mate-desktop/${PN}"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mate-desktop/${PN}.git"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug doc introspection startup-notification"

COMMON_DEPEND=">=dev-libs/glib-2.50:2
	>=gnome-base/dconf-0.13.4:0
	x11-libs/cairo:0
	>=x11-libs/gdk-pixbuf-2.4:2[introspection?]
	>=x11-libs/gtk+-3.22.0:3[introspection?]
	x11-libs/libX11:0
	>=x11-libs/libXrandr-1.3:0
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.9.7:0 )
	startup-notification? ( >=x11-libs/startup-notification-0.5:0 )"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=gnome-base/dconf-0.10:0
	sys-devel/gettext:0
	virtual/pkgconfig:0
	x11-base/xorg-proto
	doc? ( >=dev-util/gtk-doc-1.4:0 )"
RDEPEND="${COMMON_DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )

src_unpack() {
	git-r3_src_unpack
}

src_configure() {
	local emesonargs=(
		-Dmate-about=true
		-Dpnp-ids-path=internal
		$(meson_use doc gtk-doc)
		$(meson_use introspection)
		$(meson_use startup-notification)
	)
	meson_src_configure
}