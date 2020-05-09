# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs xdg-utils

DESCRIPTION="Mainly full-color painting software for illustration drawing"
HOMEPAGE="http://azsky2.html.xdomain.jp/soft/azpainter.html"
SRC_URI="http://azsky2.html.xdomain.jp/arc/${P}-200428.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libjpeg-turbo
	media-libs/libpng:*
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi"
DEPEND=${COMMON_DEPEND}
RDEPEND=${COMMON_DEPEND}

RESTRICT="mirror"

PATCHES=( "${FILESDIR}"/${P}-fix-configure-script.patch )
DOCS=( AUTHORS ChangeLog README README_ja manual_ja.html translation )

src_prepare (){
	default

	# Respect Portage's envvars.
	sed -i -e 's:^CC=:CC="'"$(tc-getCC)"'":' -e 's:^CFLAGS=:CFLAGS="'"${CFLAGS} "'":'  \
		-e 's:^LDFLAGS=:LDFLAGS="'"${LDFLAGS} "'":' -e 's:^LIBS=:LIBS="'"${LIBS} "'":'  configure \
		|| die
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
