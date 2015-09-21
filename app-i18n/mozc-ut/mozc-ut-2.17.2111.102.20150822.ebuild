# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# Mozc doesn't support Python 3 yet.
PYTHON_COMPAT=( python2_7 )

inherit elisp-common eutils git-r3 multilib multiprocessing python-single-r1 \
	toolchain-funcs versionator
use test && inherit subversion

DESCRIPTION="Mozc Japanese Input Method with Additional Japanese dictionary"
HOMEPAGE="http://www.geocities.jp/ep3797/mozc_01.html
	https://github.com/google/mozc"

UT_VER=$(get_version_component_range $(get_version_component_count))
UT_DIR="8/8903"

# ZIP codes are revised monthly.
ZIPCODE_REV="201508"

MOZC_VER=$(get_version_component_range 1-$(get_last_version_component_index))
MOZC_REV="0605d8b"
USAGEDIC_REV="HEAD"
GYP_REV="cdf037c"

# The dependency on protobuf version is near 2.5.0 (172019c).
# See Mozc commit 444f8a7 https://github.com/google/mozc/commit/444f8a7
PROTOBUF_REV="172019c"

# Use JsonCpp in the system-global's.
# JSONCPP_REV="11086dd"

GMOCK_REV="501"
GTEST_REV="700"
FCITX_PATCH_VER="2.17.2102.102.1"
UIM_PATCH_REV="0562676"

UT_URI="mirror://sourceforge.jp/users/${UT_DIR}/mozcdic-ut-${UT_VER}.tar.bz2"

# We must clone Mozc by git to manage its versions.
MOZC_URI="https://github.com/google/mozc.git"

USAGEDIC_URI="https://github.com/hiroyuki-komatsu/japanese-usage-dictionary.git"
ZIP1_URI="http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip"
ZIP2_URI="http://www.post.japanpost.jp/zipcode/dl/jigyosyo/zip/jigyosyo.zip"
EDICT_URI="http://ftp.monash.edu.au/pub/nihongo/edict.gz"

GYP_URI="https://chromium.googlesource.com/external/gyp.git"
PROTOBUF_URI="https://github.com/google/protobuf.git"
# JSONCPP_URI="https://github.com/open-source-parsers/jsoncpp.git"
GMOCK_URI="https://googlemock.googlecode.com/svn/trunk"
GTEST_URI="https://googletest.googlecode.com/svn/trunk"
FCITX_PATCH_URI="http://download.fcitx-im.org/fcitx-mozc/fcitx-mozc-${FCITX_PATCH_VER}.patch"
UIM_PATCH_URI="https://github.com/e-kato/macuim.git"

EGIT_REPO_URI=${MOZC_URI}
EGIT_COMMIT=${MOZC_REV}
EGIT_CHECKOUT_DIR="${WORKDIR}/mozcdic-ut-${UT_VER}/mozc_src"

SRC_URI="${UT_URI}
	${ZIP1_URI} -> jp-zipcode${ZIPCODE_REV}-1.zip
	${ZIP2_URI} -> jp-zipcode${ZIPCODE_REV}-2.zip
	${EDICT_URI} -> monash-nihongo-edict.gz
	fcitx? ( ${FCITX_PATCH_URI} )"

# MAKE SURE:
# 	The licenses of nicodic as well as hatena-keyword are unknown.
# 	Therefore they can be all-rights-reserved.
LICENSE="BSD BSD-2 CC-BY-SA-3.0 GPL-2 all-rights-reserved ipadic public-domain
	unicode ejdic? ( wn-ja )  test? ( Boost-1.0 )"
SLOT="0"
KEYWORDS=""
IUSE="clang ejdic emacs fcitx ibus -nicodic +qt4 renderer -test uim"
REQUIRED_USE="|| ( emacs fcitx ibus uim )"

# NOTE: Here isn't protobuf.
#	    We should use specific revision for protobuf.
COMMON_DEPEND="${PYTHON_DEPS}
	!app-i18n/mozc
	dev-libs/glib:2
	>=dev-libs/jsoncpp-0.7.0
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
	test? ( dev-vcs/subversion )"
RDEPEND="${COMMON_DEPEND}
	qt4? ( app-i18n/tegaki-zinnia-japanese )"

S="${WORKDIR}/${P}/src"
UT_SRC="${WORKDIR}/mozcdic-ut-${UT_VER}"
use test || RESTRICT="test"

BUILDTYPE=${BUILDTYPE:-Release}

SITEFILE="50${PN%-ut}-gentoo.el"

pkg_pretend(){
	if use nicodic ; then
		ewarn "WARNING:"
		ewarn "The author of Mozc UT recommends disabling its NICODIC feature,"
		ewarn "because the license of NICODIC isn't clear."
		ewarn "Are you sure to enable NICODIC feature?"
	fi
}

src_unpack() {
	unpack ${A}

	git-r3_fetch ${MOZC_URI} ${MOZC_REV} mozc
	git-r3_checkout ${MOZC_URI} "${S%/src}" mozc

	git-r3_fetch ${USAGEDIC_URI} ${USAGEDIC_REV} usagedic
	git-r3_checkout ${USAGEDIC_URI} \
		"${S}/third_party/japanese_usage_dictionary" usagedic

	git-r3_fetch ${GYP_URI} ${GYP_REV} gyp
	git-r3_checkout ${GYP_URI} "${S}/third_party/gyp" gyp

	git-r3_fetch ${PROTOBUF_URI} ${PROTOBUF_REV} protobuf
	git-r3_checkout ${PROTOBUF_URI} "${S}/third_party/protobuf" protobuf

	# git-r3_fetch ${JSONCPP_URI} ${JSONCPP_REV} jsoncpp
	# git-r3_checkout ${JSONCPP_URI} "${S}/third_party/jsoncpp" jsoncpp

	if use test ; then
		subversion_fetch ${GMOCK_URI}@${GMOCK_REV} \
			"${S}/third_party/gmock"
		subversion_fetch ${GTEST_URI}@${GTEST_REV} \
			"${S}/third_party/gtest"
	fi

	if use uim ; then
		git-r3_fetch ${UIM_PATCH_URI} ${UIM_PATCH_REV} macuim
		git-r3_checkout ${UIM_PATCH_URI} "${WORKDIR}/macuim" macuim
	fi
}

src_prepare() {
	generate-mozc-ut

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
		export GYP_DEFINES="${GYP_DEFINES} use_libzinnia=0
		zinnia_model_file=/usr/share/tegaki/models/zinnia/handwriting-ja.model"
	fi

	use renderer || export GYP_DEFINES="${GYP_DEFINES} enable_gtk_renderer=0"

	use clang || tc-export CC CXX AR AS RANLIB LD NM

	"${PYTHON}" build_mozc.py gyp --target_platform=Linux "${myconf}" || die
}

src_compile() {
	local my_makeopts="$(makeopts_jobs)"
	# This is for a safety. -j without a number, makeopts_jobs returns 999.
	local myjobs="-j${my_makeopts/999/1}"

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
	"${PYTHON}" build_mozc.py build -c "${BUILDTYPE}" ${mytarget} ${myjobs} \
		|| die

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
	dodoc "${UT_SRC}/README"
	dodoc "${UT_SRC}/AUTHORS"
	dodoc "${UT_SRC}/COPYING"
	dodoc "${UT_SRC}/ChangeLog"

	local dics=( "altcanna" "chimei" "edict" "ekimei" "hatena" "jinmei" "skk" )
	use ejdic && dics=( ${dics[@]} "wordnet-ejdic" )
	use nicodic && dics=( ${dics[@]} "niconico" )
	for dn in ${dics[@]} ; do
		docinto ${dn}
		dodoc "${UT_SRC}"/${dn}/doc/*
	done

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

generate-mozc-ut() {
	cd "${UT_SRC}"

	# get official mozcdic
	cat "${S}"/data/dictionary_oss/dictionary*.txt > mozcdic_all.txt

	# get mozcdic costlist
	ruby 32-* mozcdic_all.txt
	mv mozcdic_all.txt.cost costlist

	# get hinsi ID
	cp "${S}/data/dictionary_oss/id.def" id.def

	(
		# generate zip code dic
		ebegin "generate zip code dic"
		cd chimei/
		cp "${WORKDIR}"/*.CSV ./
		cp "${S}/dictionary/gen_zip_code_seed.py" ./
		ruby modify-zipcode.rb KEN_ALL.CSV
		python gen_zip_code_seed.py --zip_code=KEN_ALL.CSV.r \
			--jigyosyo=JIGYOSYO.CSV \
			>> "${S}/data/dictionary_oss/dictionary09.txt"
		eend

		# generate chimei.txt
		ebegin "generate chimei.txt"
		ruby get-entries.rb KEN_ALL.CSV.r
		eend
	)

	# check major ut dictionaries
	ebegin "check major ut dictionaries"
	# ruby 12-* dicfile min_hits
	ruby 12-* altcanna/altcanna.txt 300
	ruby 12-* jinmei/jinmei.txt 20
	ruby 12-* ekimei/ekimei.txt 0
	ruby 12-* chimei/chimei.txt 0
	cat altcanna/altcanna.txt.r jinmei/jinmei.txt.r ekimei/ekimei.txt.r \
		chimei/chimei.txt.r > ut-dic1.txt
	if use ejdic ; then
		ruby 12-* wordnet-ejdic/wordnet-ejdic.txt 0
		cat wordnet-ejdic/wordnet-ejdic.txt.r ut-dic1.txt > ut-dic1.txt.new
		mv ut-dic1.txt.new ut-dic1.txt
	fi
	ruby 44-* mozcdic_all.txt ut-dic1.txt
	ruby 36-* ut-dic1.txt.yomihyouki
	cat ut-dic1.txt.yomihyouki.cost mozcdic_all.txt > mozcdic_all.txt.utmajor
	eend

	# check minor ut dictionaries
	ebegin "check minor ut dictionaries"
	ruby 12-* skk/skk.txt 300
	ruby 12-* edict/edict.txt 300
	ruby 12-* hatena/hatena.txt 300
	cat skk/skk.txt.r edict/edict.txt.r hatena/hatena.txt.r > ut-dic2.txt
	if use nicodic ; then
		ruby 12-* niconico/niconico.txt 300
		cat niconico/niconico.txt.r ut-dic2.txt > ut-dic2.txt.new
		mv ut-dic2.txt.new ut-dic2.txt
	fi
	ruby 42-* mozcdic_all.txt.utmajor ut-dic2.txt
	ruby 40-* mozcdic_all.txt.utmajor ut-dic2.txt.yomi
	ruby 36-* ut-dic2.txt.yomi.hyouki
	eend

	(
		# generate katakana-eigo entries
		ebegin "generate katakana-eigo entries"
		cd edict-katakanago
		cp "${WORKDIR}/monash-nihongo-edict" ./edict
		ruby 01-* edict
		ruby 02-* edict.utf8
		ruby remove-duplicates.rb edict.utf8.kata
		cat ../mozcdic_all.txt ../*.cost ./edict.utf8.kata.r > ./edict.kata
		ruby 03-* edict.kata
		eend
	)

	# add yomigana ba
	# 「べーとーべん」から「ベートーヴェン」に変換できるようにする
	ebegin "generate babibubebo from vavivuvevo"
	cat *.cost mozcdic_all.txt edict-katakanago/edict.kata.cost \
		> ut-check-va.txt
	ruby 60-* ut-check-va.txt
	ruby 62-* ut-check-va.txt.va
	eend

	# install mozcdic-ut
	cat *.cost edict-katakanago/edict.kata.cost *.va.to_ba > dictionary-ut.txt

	cat dictionary-ut.txt \
		"${S}/data/dictionary_oss/dictionary00.txt" > dictionary00.txt
	mv dictionary00.txt "${S}/data/dictionary_oss/"

	# change mozc branding
	sed -i 's/"Mozc"/"Mozc-UT"/g' "${S}/base/const.h"

	cd "${S}"
}
