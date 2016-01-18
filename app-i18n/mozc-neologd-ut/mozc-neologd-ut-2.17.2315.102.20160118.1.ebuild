# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# Mozc doesn't support Python 3 yet.
PYTHON_COMPAT=( python2_7 )

inherit elisp-common eutils git-r3 multilib multiprocessing python-single-r1 \
	python-utils-r1 toolchain-funcs versionator

MY_PN=${PN/mozc/mozcdic}

DESCRIPTION="Mozc Japanese Input Method with mecab-ipadic-NEologd"
HOMEPAGE="http://www.geocities.jp/ep3797/mozc_01.html
	https://github.com/neologd/mecab-ipadic-neologd
	https://github.com/google/mozc"

DIC_VER="$(get_version_component_range $(get_last_version_component_index))"
UT_VER="20160118"
UT_REV="$(get_version_component_range $(get_version_component_count))"
UT_DIR="9/9809"

# ZIP codes are revised monthly.
ZIPCODE_REV="201512"

MOZC_VER="$(get_version_component_range 1-$(get_last_version_component_index))"
MOZC_REV="80c7fb8"
NEOLOGD_REV="6dd67e0"
USAGEDIC_REV="HEAD"
FCITX_PATCH_VER="2.17.2313.102.1"
UIM_PATCH_REV="3ea28b1"

UT_URI="mirror://osdn/users/${UT_DIR}/${MY_PN}-${UT_VER}.${UT_REV}.tar.bz2"

MOZC_URI="https://github.com/google/mozc.git"
NEOLOGD_URI="https://github.com/neologd/mecab-ipadic-neologd.git"
USAGEDIC_URI="https://github.com/hiroyuki-komatsu/japanese-usage-dictionary.git"
ZIP1_URI="http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip"
ZIP2_URI="http://www.post.japanpost.jp/zipcode/dl/jigyosyo/zip/jigyosyo.zip"
FCITX_PATCH_URI="http://download.fcitx-im.org/fcitx-mozc/fcitx-mozc-${FCITX_PATCH_VER}.patch"
UIM_PATCH_URI="https://github.com/e-kato/macuim.git"

EGIT_REPO_URI=${MOZC_URI}
EGIT_COMMIT=${MOZC_REV}

SRC_URI="${UT_URI}
	${ZIP1_URI} -> jp-zipcode${ZIPCODE_REV}-1.zip
	${ZIP2_URI} -> jp-zipcode${ZIPCODE_REV}-2.zip
	fcitx? ( ${FCITX_PATCH_URI} )"

# - Mozc
#   + Mozc: BSD
#   + dictionary_oss: ipadic and public-domain
#   + unicode: unicode
#   + zinnia: BSD
#   + usagedic: BSD-2
#   + GYP: BSD
#   + GMOCK: Boost-1.0
#   + GTEST: BSD
#   + IPAfont is in repo, but not used.
# - mecab-ipadic-neologd: Apache-2.0
# - Hatena: all-rights-reserved
#   http://developer.hatena.ne.jp/ja/documents/keyword/misc/catalog
# - Zipcode: public-domain http://www.post.japanpost.jp/zipcode/dl/readme.html
# - Station names: public-domain
#   http://www5a.biglobe.ne.jp/~harako/data/station.htm 
# - biographical dictionary: derived from Mozc
# - Mozc Fcitx: BSD
# - MacUIM: BSD
LICENSE="Apache-2.0 BSD BSD-2 all-rights-reserved ipadic public-domain unicode
	test? ( Boost-1.0 )"
SLOT="0"
KEYWORDS=""
IUSE="clang emacs fcitx ibus +qt4 renderer -test tomoe uim"
REQUIRED_USE="|| ( emacs fcitx ibus uim )"

COMMON_DEPEND="${PYTHON_DEPS}
	!!app-i18n/mozc
	!!app-i18n/mozc-ut
	dev-libs/glib:2
	x11-libs/libXfixes
	x11-libs/libxcb
	emacs? ( virtual/emacs )
	fcitx? ( app-i18n/fcitx )
	ibus? ( >=app-i18n/ibus-1.4.1 )
	renderer? ( x11-libs/gtk+:2 )
	qt4? ( dev-qt/qtgui:4
		app-i18n/zinnia	)
	uim? ( app-i18n/uim )"
DEPEND="${COMMON_DEPEND}
	app-arch/unzip
	>=dev-lang/ruby-2.0
	dev-util/ninja
	dev-vcs/git
	virtual/pkgconfig
	clang? ( >=sys-devel/clang-3.4 )
	fcitx? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEPEND}
	qt4? ( !tomoe? ( app-i18n/tegaki-zinnia-japanese )
		tomoe? ( app-i18n/zinnia-tomoe ) )"

S="${WORKDIR}/${P}/src"
UT_SRC="${WORKDIR}/${MY_PN}-${UT_VER}.${UT_REV}"
NEOLOGD_SRC="${WORKDIR}/mecab-ipadic-neologd"

RESTRICT="mirror"
use test || RESTRICT="${RESTRICT} test"

BUILDTYPE=${BUILDTYPE:-Release}

SITEFILE="50${PN%-ut}-gentoo.el"

DOCS=( "${UT_SRC}/AUTHORS" "${UT_SRC}/ChangeLog" "${UT_SRC}/COPYING"
	"${UT_SRC}/README" )

MOZC_DOCS=( "${S%/src}/AUTHORS" "${S%/src}/CONTRIBUTING.md"
	"${S%/src}/CONTRIBUTORS" "${S%/src}/README.md"
	"${S%/src}/doc/about_branding.md" "${S%/src}/doc/release_history.md"
	"${S%/src}/doc/design_doc" )

NEOLOGD_DOCS=( "${NEOLOGD_SRC}/COPYING" "${NEOLOGD_SRC}/ChangeLog"
	"${NEOLOGD_SRC}/README.md" "${NEOLOGD_SRC}/README.ja.md" )

src_unpack() {
	unpack ${A}

	git-r3_fetch ${MOZC_URI} ${MOZC_REV} mozc
	git-r3_checkout ${MOZC_URI} "${S%/src}" mozc

	git-r3_fetch ${NEOLOGD_URI} ${NEOLOGD_REV} neologd
	git-r3_checkout ${NEOLOGD_URI} ${NEOLOGD_SRC} neologd

	git-r3_fetch ${USAGEDIC_URI} ${USAGEDIC_REV} usagedic
	git-r3_checkout ${USAGEDIC_URI} \
		"${S}/third_party/japanese_usage_dictionary" usagedic

	if use uim ; then
		git-r3_fetch ${UIM_PATCH_URI} ${UIM_PATCH_REV} macuim
		git-r3_checkout ${UIM_PATCH_URI} "${WORKDIR}/macuim" macuim
	fi
}

src_prepare() {
	generate-mozc-neologd-ut

	if use fcitx ; then
		rm -rf unix/fcitx/
		EPATCH_OPTS="-p2" epatch "${DISTDIR}/$(basename ${FCITX_PATCH_URI})"
	fi

	if use uim ; then
		rm -rf unix/uim/
		cp -r "${WORKDIR}/macuim/Mozc/uim" "${S}/unix/"
		epatch "${FILESDIR}/mozc-kill-line.diff"
	fi

	if ! use clang ; then
		sed -i -e "s/<!(which clang)/$(tc-getCC)/" \
			-e "s/<!(which clang++)/$(tc-getCXX)/" \
			gyp/common.gypi || die
	fi
}

src_configure() {
	if use clang ; then
		export GYP_DEFINES="compiler_target=clang compiler_host=clang"
	else
		export GYP_DEFINES="compiler_target=gcc compiler_host=gcc"
	fi

	local myconf="--server_dir=/usr/$(get_libdir)/mozc"

	use ibus && export GYP_DEFINES="${GYP_DEFINES}
		ibus_mozc_path=/usr/libexec/ibus-engine-mozc
		ibus_mozc_icon_path=/usr/share/ibus-mozc/product_icon.png"

	if ! use qt4 ; then
		myconf="${myconf} --noqt"
	elif use tomoe ; then
		export GYP_DEFINES="${GYP_DEFINES}
		zinnia_model_file=/usr/$(get_libdir)/zinnia/model/tomoe/handwriting-ja.model"
	else
		export GYP_DEFINES="${GYP_DEFINES}
		zinnia_model_file=/usr/share/tegaki/models/zinnia/handwriting-ja.model"
	fi

	use renderer || export GYP_DEFINES="${GYP_DEFINES} enable_gtk_renderer=0"

	use clang || tc-export CC CXX AR AS RANLIB LD NM

	"${PYTHON}" build_mozc.py gyp --target_platform=Linux "${myconf}" || die
}

src_compile() {
	local mytarget="server/server.gyp:mozc_server"
	use emacs && mytarget="${mytarget} unix/emacs/emacs.gyp:mozc_emacs_helper"
	use fcitx && mytarget="${mytarget} unix/fcitx/fcitx.gyp:fcitx-mozc"
	use ibus && mytarget="${mytarget} unix/ibus/ibus.gyp:ibus_mozc"
	if use qt4 ; then
		QTDIR="${EPREFIX}/usr"
		mytarget="${mytarget} gui/gui.gyp:mozc_tool"
	fi
	use renderer && mytarget="${mytarget} renderer/renderer.gyp:mozc_renderer"
	use uim && mytarget="${mytarget} unix/uim/uim.gyp:uim-mozc"

	use clang || tc-export CC CXX AR AS RANLIB LD
	"${PYTHON}" build_mozc.py build -c "${BUILDTYPE}" ${mytarget} || die

	use emacs && elisp-compile unix/emacs/*.el
}

src_test() {
	"${PYTHON}" build_mozc.py runtests -c "${BUILDTYPE}"
}

src_install() {
	exeinto "/usr/$(get_libdir)/mozc"
	(
		cd "out_linux/${BUILDTYPE}"
		doexe mozc_server
		doexe protoc
		for f in gen_* ; do
			doexe "${f}"
		done
	)

	einstalldocs
	docinto mozc
	dodoc -r ${MOZC_DOCS[@]}
	docinto mecab-ipadic-neologd
	dodoc -r ${NEOLOGD_DOCS[@]}

	if use emacs ; then
		dobin "out_linux/${BUILDTYPE}/mozc_emacs_helper"
		elisp-install ${PN%-ut} unix/emacs/*.{el,elc}
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${PN%-ut}
	fi

	if use fcitx ; then
		exeinto "/usr/$(get_libdir)/fcitx"
		doexe "out_linux/${BUILDTYPE}/fcitx-mozc.so"
		insinto /usr/share/fcitx/addon
		doins unix/fcitx/fcitx-mozc.conf
		insinto /usr/share/fcitx/inputmethod
		doins unix/fcitx/mozc.conf
		insinto /usr/share/fcitx/mozc/icon
		(
			cd data/images
			newins product_icon_32bpp-128.png mozc.png
			cd unix
			for f in ui-* ; do
				newins "${f}" "mozc-${f/ui-}"
			done
		)
		for mofile in out_linux/${BUILDTYPE}/gen/unix/fcitx/po/*.mo ; do
			filename="$(basename ${mofile})"
			lang="${filename/.mo/}"
			insinto "/usr/share/locale/${lang}/LC_MESSAGES/"
			newins "${mofile}" fcitx-mozc.mo
		done
	fi

	if use ibus ; then
		exeinto /usr/libexec
		newexe "out_linux/${BUILDTYPE}/ibus_mozc" "ibus-engine-mozc"
		sed -i \
			"s_lib/ibus-mozc/ibus-engine-mozc_libexec/ibus-engine-mozc_g" \
			"out_linux/${BUILDTYPE}/gen/unix/ibus/mozc.xml"
		insinto /usr/share/ibus/component
		doins "out_linux/${BUILDTYPE}/gen/unix/ibus/mozc.xml"
		insinto /usr/share/ibus-mozc
		(
			cd data/images/unix
			newins ime_product_icon_opensource-32.png product_icon.png
			for f in ui-* ; do
				newins "${f}" "${f/ui-}"
			done
		)
	fi

	if use qt4 ; then
		exeinto "/usr/$(get_libdir)/mozc"
		doexe "out_linux/${BUILDTYPE}/mozc_tool"
	fi

	if use renderer ; then
		exeinto "/usr/$(get_libdir)/mozc"
		doexe "out_linux/${BUILDTYPE}/mozc_renderer"
	fi

	if use uim ; then
		exeinto "/usr/$(get_libdir)/uim/plugin"
		doexe "out_linux/${BUILDTYPE}/libuim-mozc.so"
		insinto /usr/share/uim/pixmaps/
		(
			cd data/images/unix
			newins ime_product_icon_opensource-32.png mozc.png
			newins ui-dictionary.png mozc_tool_uim_dictionary_tool.png
			newins ui-properties.png mozc_tool_uim_config_dialog.png
			newins ui-tool.png mozc_tool_uim_selector.png
		)
		insinto /usr/share/uim
		(
			cd "${WORKDIR}/macuim/Mozc/scm"
			for f in *.scm ; do
				doins "${f}"
			done
		)
	fi
}

pkg_postinst() {
	if use emacs ; then
		elisp-site-regen
		elog " You can use mozc-mode via LEIM (Library of Emacs Input Method)."
		elog " Write the following settings into your init file"
		elog "(~/.emacs.d/init.el or ~/.emacs) in order to use mozc-mode"
		elog "by default, or you can call \`set-input-method'"
		elog "and set \"japanese-mozc\" anytime you have loaded mozc.el"
		elog
		elog "  (require 'mozc)"
		elog "  (setq default-input-method \"japanese-mozc\")"
		elog "  (set-language-environment \"Japanese\")"
		elog
		elog " Having the above settings, just type C-\\ which is bound to"
		elog "\`toggle-input-method' by default."
	fi
	use uim && uim-module-manager --register mozc
}

pkg_postrm() {
	use emacs && elisp-site-regen
	use uim && uim-module-manager --unregister mozc
}

generate-mozc-neologd-ut() {
	# change mozc branding
	epatch ${FILESDIR}/${PN}-change-branding.patch
	sed -i -e "s/NErUTr/NEologd rel: ${DIC_VER}, UT rev: ${UT_REV}/g" \
		"${S}/gui/about_dialog/about_dialog.ui" \
		"${S}/gui/about_dialog/about_dialog_en.ts" \
		"${S}/gui/about_dialog/about_dialog_ja.ts" || die "Failed to add info"
	if use qt4 ; then
		/usr/$(get_libdir)/qt4/bin/lrelease \
			"${S}/gui/about_dialog/about_dialog_en.ts"
		/usr/$(get_libdir)/qt4/bin/lrelease \
			"${S}/gui/about_dialog/about_dialog_ja.ts"
	fi

	cd "${UT_SRC}"

	rm mecab-ipadic-neologd/mecab-user-dict-seed.${UT_VER}.csv.xz
	cp "${WORKDIR}"/mecab-ipadic-neologd/seed/mecab-user-dict-seed.${DIC_VER}.csv.xz \
		mecab-ipadic-neologd/

	# get official mozcdic
	cat "${S}"/data/dictionary_oss/dictionary*.txt > mozcdic.txt

	# get mozcdic costlist
	ebegin "getting costlist"
	ruby 01-* mozcdic.txt
	eend

	# get hinsi ID
	cp "${S}/data/dictionary_oss/id.def" id.def

	# generate mozcdic-neologd-ut
	cp "mecab-ipadic-neologd/mecab-user-dict-seed.${DIC_VER}.csv.xz" ./

	ebegin "extracting mecab-user-dict-seed.${DIC_VER}.csv.xz"
	xz -d "mecab-user-dict-seed.${DIC_VER}.csv.xz"
	eend

	ebegin "generating neologd.txt"
	ruby 03-* "mecab-user-dict-seed.${DIC_VER}.csv"
	eend

	ebegin "generating mozcdic-neologd-ut.txt"
	ruby 05-*
	eend

	# install mozcdic-neologd-ut
	cat mozcdic-neologd-ut.txt "${S}/data/dictionary_oss/dictionary00.txt" \
		> dictionary00.txt
	mv dictionary00.txt "${S}/data/dictionary_oss/dictionary00.txt"

	# generate zip code dic
	ebegin "generate zip code dic"
	cp "${S}/dictionary/gen_zip_code_seed.py" ./
	cp "${WORKDIR}"/*.CSV ./
	ruby 07-* KEN_ALL.CSV
	"${PYTHON}" gen_zip_code_seed.py --zip_code=KEN_ALL.CSV.r \
		--jigyosyo=JIGYOSYO.CSV \
		>> "${S}/data/dictionary_oss/dictionary09.txt"
	eend

	cd "${S}"
}
