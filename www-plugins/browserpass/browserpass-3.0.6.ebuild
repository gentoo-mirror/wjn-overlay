# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/browserpass/browserpass-native

if [[ ${PV} == 9999 ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64"
	SRC_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="WebExtension host binary for pass, a UNIX password manager"
HOMEPAGE="https://github.com/browserpass/browserpass-native"
LICENSE="ISC"
SLOT="0"

RDEPEND="app-crypt/gnupg"
DEPEND="${RDEPEND}
	>=dev-go/go-sys-0_pre20180816:=
	>=dev-go/lfshook-2.4:=
	>=dev-go/logrus-1.4.0:=
	>=dev-go/zglob-0_p20171230:="

RESTRICT="mirror"

DOCS=( PROTOCOL.md README.md )

src_prepare() {
	eapply_user
	
	pushd "src/${EGO_PN}" >/dev/null || die
	sed -e 's|%%replace%%|'${EPREFIX}'/usr/bin/browserpass-native|' \
		-i browser-files/firefox-host.json browser-files/chromium-host.json || die
	popd >/dev/null || die
}

src_compile() {
	BIN=browserpass golang-build_src_compile
}

src_install() {
	dobin browserpass-native

	pushd "src/${EGO_PN}" >/dev/null || die

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

	popd >/dev/null || die
}
