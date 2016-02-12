# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

# Mozc doesn't support Python 3 yet.
PYTHON_COMPAT=( python2_7 )

inherit elisp-common git-r3 python-single-r1 python-utils-r1 toolchain-funcs \
	versionator

MY_PN=${PN/mozc/mozcdic}

DESCRIPTION="Mozc Japanese Input Method with Additional Japanese dictionary"
HOMEPAGE="http://www.geocities.jp/ep3797/mozc_01.html
	https://github.com/google/mozc"

# Assign version variables #####
MOZC_VER="$(get_version_component_range 1-4)"
MOZC_REV="070bf2a"
FCITX_PATCH_VER="2.17.2313.102.1"
UIM_PATCH_REV="3ea28b1"

# Zip code data are revised on the last of every month
ZIPCODE_REV="201601"

UT_REL=$(get_version_component_range $(get_version_component_count))
UT_DIR="9/9843"
#######################

# Assign URI variables #########
MOZC_URI="https://github.com/google/mozc.git"
FCITX_PATCH_URI="http://download.fcitx-im.org/fcitx-mozc/fcitx-mozc-${FCITX_PATCH_VER}.patch"
UIM_PATCH_URI="https://github.com/e-kato/macuim.git"

ZIP1_URI="http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip"
ZIP2_URI="http://www.post.japanpost.jp/zipcode/dl/jigyosyo/zip/jigyosyo.zip"
EDICT_URI="http://ftp.monash.edu.au/pub/nihongo/edict.gz"

UT_URI="mirror://osdn/users/${UT_DIR}/mozcdic-ut-${UT_REL}.tar.bz2"
#######################

SRC_URI="${UT_URI}
	${ZIP1_URI} -> jp-zipcode${ZIPCODE_REV}-1.zip
	${ZIP2_URI} -> jp-zipcode${ZIPCODE_REV}-2.zip
	${EDICT_URI} -> monash-nihongo-edict.gz
	fcitx? ( ${FCITX_PATCH_URI} )"
EGIT_REPO_URI=${MOZC_URI}
EGIT_COMMIT=${MOZC_REV}

# CAUTION:
# 	The license of nicodic is NOT CLEAR -> nicodic is not recommended
#
# LICENSES
# - UT ruby/shell scripts: GPL
# - Mozc
#   + Mozc: BSD
#   + dictionary_oss: ipadic and public-domain
#   + unicode: unicode
#   + zinnia: BSD
#   + usagedic: BSD-2
#   + GYP: BSD
#   + GMOCK: BSD
#   + GTEST: BSD
#   + IPAfont is in repo, but not used
# - alt-cannadic: GPL-2+
# - biographical dictionary: GPL-3+
# - SKK-JISYO.L: GPL-2+
# - Hatena: free-noncomm
#   http://developer.hatena.ne.jp/ja/documents/keyword/misc/catalog
# - EDICT: CC-BY-SA-3.0
# 	http://www.edrdg.org/jmdict/edict.html
# - Zipcode: public-domain http://www.post.japanpost.jp/zipcode/dl/readme.html
# - Station names: public-domain
#   http://www5a.biglobe.ne.jp/~harako/data/station.htm
# - Japanese WordNet: wn-ja
# 	http://nlpwww.nict.go.jp/wn-ja/license.txt
# - niconico: ** NOT CLEAR ** (This may mean all-rights-reserved)
#   http://tkido.com/blog/1019.html
# - Mozc Fcitx: BSD
# - MacUIM: BSD
LICENSE="BSD BSD-2 CC-BY-SA-3.0 GPL-2+ GPL-3+ all-rights-reserved
	free-noncomm ipadic public-domain unicode ejdic? ( wn-ja )"
SLOT="0"
KEYWORDS=""
IUSE="clang ejdic emacs fcitx ibus -nicodic +qt4 renderer -test tomoe uim"
REQUIRED_USE="|| ( emacs fcitx ibus uim )"

COMMON_DEPEND="${PYTHON_DEPS}
	!!app-i18n/mozc
	!!app-i18n/mozc-neologd-ut
	dev-libs/glib:2
	x11-libs/libXfixes
	x11-libs/libxcb
	emacs? ( virtual/emacs )
	fcitx? ( app-i18n/fcitx )
	ibus? ( >=app-i18n/ibus-1.4.1 )
	qt4? ( dev-qt/qtcore:4
		dev-qt/qtgui:4
		app-i18n/zinnia	)
	renderer? ( x11-libs/gtk+:2 )
	uim? ( app-i18n/uim )"
DEPEND="${COMMON_DEPEND}
	app-arch/unzip
	app-i18n/nkf
	>=dev-lang/ruby-2.0
	dev-util/ninja
	virtual/pkgconfig
	clang? ( >=sys-devel/clang-3.4 )
	fcitx? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEPEND}
	qt4? ( !tomoe? ( app-i18n/tegaki-zinnia-japanese )
		tomoe? ( app-i18n/zinnia-tomoe ) )"

S="${WORKDIR}/${P}/src"
UT_S="${WORKDIR}/${MY_PN}-${UT_REL}"

RESTRICT="mirror test"

BUILDTYPE=${BUILDTYPE:-Release}

SITEFILE="50${PN%-ut}-gentoo.el"

DOCS=( "${UT_S}/AUTHORS" "${UT_S}/ChangeLog" "${UT_S}/COPYING"
	"${UT_S}/README" )

MOZC_DOCS=( "${S%/src}/AUTHORS" "${S%/src}/CONTRIBUTING.md"
	"${S%/src}/CONTRIBUTORS" "${S%/src}/README.md"
	"${S%/src}/doc/about_branding.md" "${S%/src}/doc/release_history.md"
	"${S%/src}/doc/design_doc" )

pkg_pretend(){
	if use nicodic ; then
		ewarn 'WARNING:'
		ewarn 'The author of Mozc UT recommends disabling its NICODIC feature,'
		ewarn 'because NICODIC is all-rights-reserved.'
		ewarn 'See also: http://tkido.com/blog/1019.html'
		ewarn 'Are you sure to enable NICODIC feature?'
		echo -n '   '
		for num in 5 4 3 2 1 ; do
			echo -n "${num} "
			sleep 1
		done
		echo
	fi
}

src_unpack() {
	unpack ${A}

	git-r3_fetch ${MOZC_URI} ${MOZC_REV} mozc
	git-r3_checkout ${MOZC_URI} "${S%/src}" mozc

	if use uim ; then
		git-r3_fetch ${UIM_PATCH_URI} ${UIM_PATCH_REV} macuim
		git-r3_checkout ${UIM_PATCH_URI} "${WORKDIR}/macuim" macuim
	fi
}

src_prepare() {
	# Document files of altcanna are EUC-JP encoded, should be converted to UTF-8
	for f_n in "${UT_S}"/altcanna/doc/* ; do
		nkf -E -w --overwrite ${f_n}
	done

	# This function is declared at the last of this file
	generate-mozc-ut

	if use fcitx ; then
		rm -rf unix/fcitx/
		eapply -p2 "${DISTDIR}/$(basename ${FCITX_PATCH_URI})"
	fi

	if use uim ; then
		rm -rf unix/uim/
		cp -r "${WORKDIR}/macuim/Mozc/uim" "${S}/unix/"
		eapply -p0 "${WORKDIR}/macuim/Mozc/mozc-kill-line.diff"
	fi

	if ! use clang ; then
		sed -i -e "s/<!(which clang)/$(tc-getCC)/" \
			-e "s/<!(which clang++)/$(tc-getCXX)/" \
			gyp/common.gypi || die
	fi

	eapply_user
}

src_configure() {
	if use clang ; then
		export GYP_DEFINES="compiler_target=clang compiler_host=clang"
	else
		export GYP_DEFINES="compiler_target=gcc compiler_host=gcc"
		tc-export CC CXX AR AS RANLIB LD NM
	fi

	use ibus && export GYP_DEFINES="${GYP_DEFINES}
		ibus_mozc_path=/usr/libexec/ibus-engine-mozc
		ibus_mozc_icon_path=/usr/share/ibus-mozc/product_icon.png"

	local myconf
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

	"${PYTHON}" build_mozc.py gyp --target_platform=Linux \
		--server_dir="/usr/$(get_libdir)/mozc" "${myconf}" \
		|| die 'Failed to execute "build_mozc.py gyp"'
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
	"${PYTHON}" build_mozc.py build -c "${BUILDTYPE}" ${mytarget} \
		|| die 'Failed to execute "build_mozc.py build"'

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

	local dic_names=( "altcanna" "chimei" "edict" "ekimei" "hatena" "jinmei"
		"skk" )
	use ejdic && dic_names=( ${dic_names[@]} "wordnet-ejdic" )
	use nicodic && dic_names=( ${dic_names[@]} "niconico" )
	for dic_name in ${dic_names[@]} ; do
		docinto ${dic_name}
		dodoc "${UT_S}"/${dic_name}/doc/*
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
	einfo "Adding mozc-ut version information"
	eapply "${FILESDIR}/${PN}-add-ut-info.patch"

	# Converting "ba-jonn", UT release date is also printed
	sed -i -e 's/\(GetMozcVersion()\);/\1 + ".'"${UT_REL}"'";/g' \
		rewriter/version_rewriter.cc \
		|| die "Failed to add ut info to Mozc version_rewriter"

	if use qt4 ; then
		# Add UT information to Mozc's about_dialog
		# e.g. when you execute "/usr/lib/mozc/mozc_tool -mode about_dialog"
		sed -i -e \
			"s_UTr_/ release date: ${UT_REL}_g" \
			"${S}/gui/about_dialog/about_dialog.ui" \
			"${S}/gui/about_dialog/about_dialog_en.ts" \
			"${S}/gui/about_dialog/about_dialog_ja.ts" \
			|| die "Failed to add ut info to Mozc about_dialog"
		"/usr/$(get_libdir)/qt4/bin/lrelease" -silent \
			"${S}/gui/about_dialog/about_dialog_en.ts"
		"/usr/$(get_libdir)/qt4/bin/lrelease" -silent \
			"${S}/gui/about_dialog/about_dialog_ja.ts" \
			|| die "Failed to recompile translation file"
	fi

	# For running UT scripts ############
	cd "${UT_S}"

	ebegin "Getting mozcdic costlist"
	cat "${S}"/data/dictionary_oss/dictionary*.txt > mozcdic_all.txt
	ruby 01-* mozcdic_all.txt || die "Failed to get mozcdic costlist"
	eend

	einfo "Copying hinshi ID"
	cp "${S}/data/dictionary_oss/id.def" id.def \
		|| die "Failed to copy hinshi ID"

	(
		ebegin "Generating zip code dictionary"
		cd chimei/
		cp "${WORKDIR}"/*.CSV ./
		cp "${S}/dictionary/gen_zip_code_seed.py" ./
		ruby modify-zipcode.rb KEN_ALL.CSV || die
		"${PYTHON}" gen_zip_code_seed.py --zip_code=KEN_ALL.CSV.r \
			--jigyosyo=JIGYOSYO.CSV \
			>> "${S}/data/dictionary_oss/dictionary09.txt" \
				|| die "Failed to generate zip code dictionary"
		eend

		ebegin "Generating chimei.txt"
		ruby get-entries.rb KEN_ALL.CSV.r \
			|| die "Failed to generate chimei.txt"
		eend
	)

	ebegin "Checking major ut dictionaries"
	# ruby 03-* dicfile min_hits || die
	ruby 03-* altcanna/altcanna.txt 300 || die "Failed to tune altcanna.txt"
	ruby 03-* jinmei/jinmei.txt 20 || die "Failed to tune jinmei.txt"
	ruby 03-* ekimei/ekimei.txt 0 || die "Failed to tune ekimei.txt"
	ruby 03-* chimei/chimei.txt 0 || die "Failed to tune chimei.txt"
	cat altcanna/altcanna.txt.r jinmei/jinmei.txt.r ekimei/ekimei.txt.r \
		chimei/chimei.txt.r > ut-dic1.txt
	if use ejdic ; then
		ruby 03-* wordnet-ejdic/wordnet-ejdic.txt 0 \
			|| die  "Failed to tune wordnet-ejdic.txt"
		cat wordnet-ejdic/wordnet-ejdic.txt.r ut-dic1.txt > ut-dic1.txt.new
		mv ut-dic1.txt.new ut-dic1.txt
	fi
	ruby 05-* mozcdic_all.txt ut-dic1.txt || die "Failed to remove duplicates"
	ruby 11-* ut-dic1.txt.yomihyouki || die "Failed to apply cost and hinshi"
	cat ut-dic1.txt.yomihyouki.cost mozcdic_all.txt > mozcdic_all.txt.utmajor
	eend

	ebegin "Checking minor ut dictionaries"
	ruby 03-* skk/skk.txt 300 || die "Failed to tune skk.txt"
	ruby 03-* edict/edict.txt 300 || die "Failed to tune edict.txt"
	ruby 03-* hatena/hatena.txt 300 || die "Failed to tune hatena.txt"
	cat skk/skk.txt.r edict/edict.txt.r hatena/hatena.txt.r > ut-dic2.txt
	if use nicodic ; then
		ruby 03-* niconico/niconico.txt 300 \
			|| die "Failed to tune niconico.txt"
		cat niconico/niconico.txt.r ut-dic2.txt > ut-dic2.txt.new
		mv ut-dic2.txt.new ut-dic2.txt
	fi
	ruby 07-* mozcdic_all.txt.utmajor ut-dic2.txt \
		|| die "Failed to remove duplicates of yomi"
	ruby 09-* mozcdic_all.txt.utmajor ut-dic2.txt.yomi \
		|| die "Failed to remove duplicates of hyouki"
	ruby 11-* ut-dic2.txt.yomi.hyouki \
		|| die "Failed to apply cost and hinshi"
	eend

	(
		ebegin "Generating katakana-eigo entries"
		cd edict-katakanago
		cp "${WORKDIR}/monash-nihongo-edict" ./edict
		ruby 01-* edict || die "Failed to convert edict to UTF-8"
		ruby 02-* edict.utf8 || die " Failed to generate entries"
		ruby remove-duplicates-mozc-format.rb edict.utf8.kata \
			|| die "Failed to remove duplicates"
		cat ../mozcdic_all.txt ../*.cost ./edict.utf8.kata.r > ./edict.kata
		ruby 03-* edict.kata || die "Failed to apply cost"
		eend
	)

	ebegin "Generating babibubebo from vavivuvevo"
	cat *.cost mozcdic_all.txt edict-katakanago/edict.kata.cost \
		> ut-check-va.txt
	ruby 60-* ut-check-va.txt || die 'Failed to generate "babibubebo" entries'
	eend

	einfo "Installing mozcdic-ut"
	cat *.cost edict-katakanago/edict.kata.cost *.to_ba > mozcdic-ut.txt
	cat mozcdic-ut.txt \
		"${S}/data/dictionary_oss/dictionary00.txt" > dictionary00.txt
	mv dictionary00.txt "${S}/data/dictionary_oss/"

	# Go back to the default directory ##
	cd "${S}"
}
