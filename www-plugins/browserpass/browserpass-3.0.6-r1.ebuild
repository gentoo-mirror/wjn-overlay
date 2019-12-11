# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="WebExtension host binary for pass, a UNIX password manager"
HOMEPAGE="https://github.com/browserpass/browserpass-native"
EGO_VENDOR=(
	"github.com/mattn/go-zglob a8912a37f9e7" # MIT
	"github.com/sirupsen/logrus v1.4.2" # MIT
	"golang.org/x/sys 6d18c012aee9febd81bbf9806760c8c4480e870d github.com/golang/sys" # BSD
	)
MY_PN="browserpass-native"
SRC_URI="https://${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	$(go-module_vendor_uris)"

LICENSE="BSD ISC MIT"
SLOT="0"

DEPEND=""
RDEPEND="app-crypt/gnupg"
KEYWORDS="~amd64"

S="${WORKDIR}/${MY_PN}-${PV}"
RESTRICT="mirror"

DOCS=( PROTOCOL.md README.md )

src_prepare() {
	eapply_user

	sed -e 's|%%replace%%|'${EPREFIX}'/usr/libexec/browserpass-native|' \
		-i browser-files/firefox-host.json browser-files/chromium-host.json || die
}

src_compile() {
	go build || die
}

src_install() {
	exeinto /usr/libexec
	doexe browserpass-native

	insinto /usr/$(get_libdir)/browserpass/hosts/firefox
	newins browser-files/firefox-host.json com.github.browserpass.native.json

	dosym \
		/usr/$(get_libdir)/browserpass/hosts/firefox/com.github.browserpass.native.json \
		/usr/$(get_libdir)/mozilla/native-messaging-hosts/com.github.browserpass.native.json

	insinto /usr/$(get_libdir)/browserpass/hosts/chromium
	newins browser-files/chromium-host.json com.github.browserpass.native.json
	insinto /usr/$(get_libdir)/browserpass/policies/chromium
	newins browser-files/chromium-policy.json com.github.browserpass.native.json

	for target in chromium iridium-browser opt/chrome opt/slimjet opt/vivaldi
	do
		dosym \
			/usr/$(get_libdir)/browserpass/hosts/chromium/com.github.browserpass.native.json \
			/etc/${target}/native-messaging-hosts/com.github.browserpass.native.json
	done

	for target in chromium opt/chrome opt/slimjet opt/vivaldi ; do
		dosym \
			/usr/$(get_libdir)/browserpass/policies/chromium/com.github.browserpass.native.json \
			/etc/${target}/policies/managed/com.github.browserpass.native.json
	done

	einstalldocs
}