# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/dannyvankooten/${PN}"
EGIT_COMMIT="1.0.2"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Host application required by Browserpass extension for ZX2C4's pass"
HOMEPAGE="https://github.com/dannyvankooten/browserpass"
SRC_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 -x86"

COMMON_DEPEND="!!app-admin/browserpass-binary-component
	dev-go/go-zglob"
DEPEND=${COMMON_DEPEND}
RDEPEND="${COMMON_DEPEND}
	|| ( www-client/google-chrome
		www-client/google-chrome-beta
		www-client/google-chrome-unstable
		www-client/chromium
		>=www-client/firefox-50
		>=www-client/firefox-bin-50 )"

S="$WORKDIR/${P}/src/${EGO_PN}"

src_prepare() {
	eapply_user

	HOST_FILE=/usr/bin/browserpass
	ESCAPED_HOST_FILE=${HOST_FILE////\\/}
	sed -i -e "s/%%replace%%/$ESCAPED_HOST_FILE/" chrome/host.json
	sed -i -e "s/%%replace%%/$ESCAPED_HOST_FILE/" firefox/host.json

	cp chrome/host.json chrome/com.dannyvankooten.browserpass.json
	cp firefox/host.json firefox/com.dannyvankooten.browserpass.json
}

src_install() {
	dobin browserpass

	insinto /etc/opt/chrome/native-messaging-hosts/
	doins "chrome/com.dannyvankooten.browserpass.json"

	insinto /etc/chromium/native-messaging-hosts/
	doins "chrome/com.dannyvankooten.browserpass.json"

	insinto /usr/lib64/mozilla/native-messaging-hosts/
	doins "firefox/com.dannyvankooten.browserpass.json"
}

pkg_postinst() {
	elog "To use Browserpass, don't forget to install the extention to your browser"
	elog "- https://chrome.google.com/webstore/detail/browserpass/jegbgfamcgeocbfeebacnkociplhmfbk"
	elog "- https://addons.mozilla.org/en-US/firefox/addon/browserpass/"
}
