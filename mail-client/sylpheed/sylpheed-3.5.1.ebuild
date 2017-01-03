# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PLOCALES="be bg cs da de el en es et eu fi fr gl he hr hu it ja ko lt nl pl
	pt_BR ro ru sk sl sr sv tr uk vi zh_CN zh_TW"
PLOCALE_BACKUP="en"

inherit eutils l10n

# these are needed for RC versions
MY_PV=${PV/_/}
MY_P="${PN}-${MY_PV}"

OSDN_DIR="66189"

DESCRIPTION="A lightweight email client and newsreader"
HOMEPAGE="http://sylpheed.sraoss.jp/"
SRC_URI="mirror://osdn/${PN}/${OSDN_DIR}/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="crypt ipv6 ldap nls oniguruma pda spell ssl xface"

COMMON_DEPEND="x11-libs/gtk+:2
	crypt? ( app-crypt/gpgme )
	ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	oniguruma? ( dev-libs/oniguruma )
	pda? ( app-pda/jpilot )
	spell? ( app-text/gtkspell:2 )
	ssl? ( || ( dev-libs/openssl:0
		dev-libs/libressl ) )"
DEPEND="${COMMON_DEPEND}
	app-i18n/nkf
	virtual/pkgconfig
	xface? ( media-libs/compface )"
RDEPEND="${COMMON_DEPEND}
	app-misc/mime-types
	net-misc/curl"

# for RC versions
S="${WORKDIR}/${MY_P%rc*}"
RESTRICT="mirror"

DOCS=( AUTHORS ChangeLog* NEWS* README* TODO* )

src_configure() {
	econf \
		--disable-updatecheck \
		--disable-updatecheckplugin \
		--without-manualdir \
		--without-faqdir \
		$(use_enable crypt gpgme) \
		$(use_enable ipv6) \
		$(use_enable ldap) \
		$(use_enable oniguruma) \
		$(use_enable pda jpilot) \
		$(use_enable spell gtkspell) \
		$(use_enable ssl) \
		$(use_enable xface compface)
}

src_install() {
	# note for the future: einstall is deprecated in EAPI 6
	einstall

	use linguas_es || rm *.es*

	if use linguas_ja ; then
		# documents in Japanese are in EUC-JP, should be converted to UTF-8
		for fn in *.ja* manual/ja/* ; do
			nkf -w --overwrite ${fn}
		done
	else
		rm *.ja*
	fi

	dodoc ${DOCS[@]}

	#  In the tarball, "PLUGIN.txt" is named for case-insensitive systems,
	# because "PLUGIN" will conflict with "plugin" directory.
	#  Therefore, let's rename "PLUGIN.txt" to "PLUGIN".
	for fn in PLUGIN*.txt ; do
		newdoc ${fn} ${fn%.txt}
	done

	docompress -x /usr/share/doc/${PF}/faq /usr/share/doc/${PF}/manual
	for dir_name in faq manual ; do
		cd "${S}/${dir_name}"
		for lang in $(find * -type d) ; do
			if [ x"${lang}" = x"en" ] \
				|| grep -q "${lang}" <(echo $(l10n_get_locales)) ; then
				rm "${lang}"/Makefile*
				rm -rf "${lang}"/no
				docinto "${dir_name}"
				dodoc -r "${lang}"
			fi
		done
	done

	cd "${S}/plugin/attachment_tool"
	emake DESTDIR="${ED}" install-plugin
	docinto ""
	newdoc README PLUGIN-ATTACHMENT_TOOL

	prune_libtool_files --modules
}

pkg_postinst() {
	if [ ${PV} == *rc* ] ; then
		elog "Note:"
		elog "  Though ${MY_PV%rc*} is shown as the version number,"
		elog " this is a Release Candidate of ${MY_PV%rc} ."
	fi
}
