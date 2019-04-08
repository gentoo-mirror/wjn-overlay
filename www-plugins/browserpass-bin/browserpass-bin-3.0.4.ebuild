# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN%%-bin}-linux64"

DESCRIPTION="Host application required by Browserpass extension for ZX2C4's pass"
HOMEPAGE="https://github.com/browserpass/browserpass-native"
SRC_URI="${HOMEPAGE}/releases/download/${PV}/${MY_PN}-${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="ISC"

SLOT="0"
KEYWORDS="~amd64 -x86"

COMMON_DEPEND="!!www-plugins/browserpass"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"
RESTRICT="mirror"

src_prepare() {
	eapply_user

	sed -i -e "s:%%replace%%:${EPREFIX}/usr/bin/browserpass-linux64:" \
		browser-files/firefox-host.json \
		browser-files/chromium-host.json browser-files/chromium-policy.json
}

src_compile() {
	:
}

src_install() {
	dobin browserpass-linux64

	insinto /usr/$(get_libdir)/browserpass/hosts/firefox
	newins browser-files/firefox-host.json com.github.browserpass.native.json

	dosym \
		/usr/$(get_libdir)/browserpass/hosts/firefox/com.github.browserpass.native.json \
		/usr/$(get_libdir)/mozilla/native-messaging-hosts/com.github.browserpass.native.json

	insinto /usr/$(get_libdir)/browserpass/hosts/chromium
	newins browser-files/chromium-host.json com.github.browserpass.native.json
	insinto /usr/$(get_libdir)/browserpass/policies/chromium
	newins browser-files/chromium-policy.json com.github.browserpass.native.json

	for target in chromium opt/chrome opt/vivaldi opt/brave ; do
		dosym \
			/usr/$(get_libdir)/browserpass/hosts/chromium/com.github.browserpass.native.json \
			/etc/${target}/native-messaging-hosts/com.github.browserpass.native.json
		dosym \
			/usr/$(get_libdir)/browserpass/policies/chromium/com.github.browserpass.native.json \
			/etc/${target}/policies/managed/com.github.browserpass.native.json
	done

	einstalldocs
}

pkg_postinst() {
	elog "To use Browserpass, don't forget to install the extention to your browser"
	elog "- https://chrome.google.com/webstore/detail/browserpass-ce/naepdomgkenhinolocfifgehidddafch"
	elog "- https://addons.mozilla.org/en-US/firefox/addon/browserpass-ce/"
	elog "- https://github.com/browserpass/browserpass-extension"
	elog "Browserpass 3.0.0 and later are not compatible with older versions"
	elog "Do not forget to reinstall extentions of your browsers"
}
