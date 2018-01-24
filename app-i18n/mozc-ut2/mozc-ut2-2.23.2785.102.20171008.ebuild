# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# Mozc doesn't support Python 3 yet
PYTHON_COMPAT=( python2_7 )

inherit elisp-common git-r3 multilib multiprocessing python-single-r1 \
	python-utils-r1 toolchain-funcs versionator 

MY_PN=${PN/mozc/mozcdic}

DESCRIPTION="Mozc Japanese Input Method with Additional Japanese dictionary"
HOMEPAGE="http://www.geocities.jp/ep3797/mozc-ut2.html
	https://github.com/google/mozc"

# Assign version variables #####
MOZC_VER="$(get_version_component_range 1-4)"
MOZC_REV="6b878e31fb6ac4347dc9dfd8ccc1080fe718479f"
FCITX_PATCH_VER="2.18.2612.102.1"
UIM_PATCH_REV="3ea28b1"

# Zip code data are revised on the last of every month
ZIPCODE_REV="201712"

UT2_REL=$(get_version_component_range $(get_version_component_count))
UT2_DIR="16/16039"
#######################

# Assign URI variables #########
MOZC_URI="https://github.com/google/mozc.git"
FCITX_PATCH_URI="http://download.fcitx-im.org/fcitx-mozc/fcitx-mozc-${FCITX_PATCH_VER}.patch"
UIM_PATCH_URI="https://github.com/e-kato/macuim.git"

ZIP1_URI="http://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip"
ZIP2_URI="http://www.post.japanpost.jp/zipcode/dl/jigyosyo/zip/jigyosyo.zip"

UT2_URI="mirror://osdn/users/${UT2_DIR}/${MY_PN}-${UT2_REL}.tar.bz2"
#######################

SRC_URI="${UT2_URI}
	${ZIP1_URI} -> jp-zipcode${ZIPCODE_REV}-1.zip
	${ZIP2_URI} -> jp-zipcode${ZIPCODE_REV}-2.zip
	fcitx? ( ${FCITX_PATCH_URI} )"

EGIT_REPO_URI=${MOZC_URI}
EGIT_COMMIT=${MOZC_REV}

# CAUTION:
#  The license of nicodic is NOT CLEAR -> nicodic is not recommended
#
# LICENSES
# - UT2 ruby/shell scripts: GPL
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
# - person name dictionary: GPL-3+
# - SKK-JISYO.L: GPL-2+
# - Hatena: free-noncomm
#   http://developer.hatena.ne.jp/ja/documents/keyword/misc/catalog
# - EDICT: CC-BY-SA-3.0
#   http://www.edrdg.org/jmdict/edict.html
# - Zipcode: public-domain http://www.post.japanpost.jp/zipcode/dl/readme.html
# - Station names: CC-BY-SA 3.0
#   https://ja.wikipedia.org/
# - Japanese WordNet: wn-ja
#   http://nlpwww.nict.go.jp/wn-ja/license.txt
# - niconico: ** NOT CLEAR ** (This may mean all-rights-reserved)
#   http://tkido.com/blog/1019.html
# - Mozc Fcitx: BSD
# - MacUIM: BSD
LICENSE="BSD BSD-2 CC-BY-SA-3.0 GPL-2+ GPL-3+ all-rights-reserved
	free-noncomm ipadic public-domain unicode ejdic? ( wn-ja )"
SLOT="0"
KEYWORDS=""
IUSE="ejdic emacs fcitx ibus -nicodic +qt5 renderer tomoe uim"
REQUIRED_USE="|| ( emacs fcitx ibus uim )
	tomoe? ( qt5 )"

COMMON_DEPEND="${PYTHON_DEPS}
	!!app-i18n/mozc
	!!app-i18n/mozc-neologd-ut
	dev-libs/glib:2
	x11-libs/libXfixes
	x11-libs/libxcb
	emacs? ( virtual/emacs )
	fcitx? ( app-i18n/fcitx )
	ibus? ( >=app-i18n/ibus-1.4.1 )
	qt5? ( dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		app-i18n/zinnia	)
	renderer? ( x11-libs/gtk+:2 )
	uim? ( app-i18n/uim )"
DEPEND="${COMMON_DEPEND}
	app-arch/unzip
	app-i18n/nkf
	>=dev-lang/ruby-2.0
	dev-util/ninja
	virtual/pkgconfig
	fcitx? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEPEND}
	qt5? ( !tomoe? ( app-i18n/tegaki-zinnia-japanese )
		tomoe? ( app-i18n/zinnia-tomoe ) )"

S="${WORKDIR}/${P}/src"
UT2_S="${WORKDIR}/${MY_PN}-${UT2_REL}"

RESTRICT="mirror test"

BUILDTYPE=${BUILDTYPE:-Release}

SITEFILE="50${PN%-ut2}-gentoo.el"

DOCS=( "${UT2_S}/AUTHORS" "${UT2_S}/ChangeLog" "${UT2_S}/COPYING"
	"${UT2_S}/README.md" "${UT2_S}"/docs )

MOZC_DOCS=( "${S%/src}/AUTHORS" "${S%/src}/CONTRIBUTING.md"
	"${S%/src}/CONTRIBUTORS" "${S%/src}/README.md"
	"${S%/src}/docs/about_branding.md" "${S%/src}/docs/release_history.md"
	"${S%/src}/docs/design_doc" )

pkg_pretend(){
	if use nicodic ; then
		ewarn 'WARNING:'
		ewarn 'The author of Mozc UT2 recommends disabling its NICODIC feature,'
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
	for f_n in "${UT2_S}"/docs/alt-cannadic/* ; do
		nkf -E -w --overwrite ${f_n}
	done

	# Delete needless documents
	use ejdic || rm -rf "${UT2_S}/docs/wordnet-ejdic"
	use nicodic || rm -rf "${UT2_S}/docs/niconico"

	# This function is declared at the last of this file
	generate-mozc-ut2

	if use fcitx ; then
		rm -rf unix/fcitx/
		eapply -p2 "${DISTDIR}/$(basename ${FCITX_PATCH_URI})"
	fi

	if use uim ; then
		rm -rf unix/uim/
		cp -r "${WORKDIR}/macuim/Mozc/uim" "${S}/unix/"
		eapply -p0 "${WORKDIR}/macuim/Mozc/mozc-kill-line.diff"
	fi

	sed -i -e "s/<!(which clang)/$(tc-getCC)/" \
		-e "s/<!(which clang++)/$(tc-getCXX)/" \
		gyp/common.gypi || die

	sed -i -e "/RunOrDie(\[ninja/s/ja, /ja, '-j"$(makeopts_jobs)"', /" \
		build_mozc.py || die

	eapply_user
}

src_configure() {
	export GYP_DEFINES="compiler_target=$(tc-getCC) compiler_host=$(tc-getCC)"
	tc-export CC CXX AR AS RANLIB LD NM

	use ibus && export GYP_DEFINES="${GYP_DEFINES}
		ibus_mozc_path=/usr/libexec/ibus-engine-mozc
		ibus_mozc_icon_path=/usr/share/ibus-mozc/product_icon.png"

	local myconf

	if use qt5 ; then
		myconf="${myconf} --qtver=5"
	else
		myconf="${myconf} --noqt"
	fi

	if use tomoe ; then
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
	if use qt5 ; then
		QTDIR="${EPREFIX}/usr"
		mytarget="${mytarget} gui/gui.gyp:mozc_tool"
	fi
	use renderer && mytarget="${mytarget} renderer/renderer.gyp:mozc_renderer"
	use uim && mytarget="${mytarget} unix/uim/uim.gyp:uim-mozc"

	tc-export CC CXX AR AS RANLIB LD
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

	insinto "/usr/$(get_libdir)/mozc/documents"
	doins data/installer/*

	einstalldocs

	dodoc -r "${UT2_S}"/docs/*

	docinto mozc
	dodoc -r ${MOZC_DOCS[@]}

	if use emacs ; then
		dobin "out_linux/${BUILDTYPE}/mozc_emacs_helper"
		elisp-install ${PN%-ut2} unix/emacs/*.{el,elc}
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${PN%-ut2}
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

	if use qt5 ; then
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

generate-mozc-ut2() {
	einfo "Adding mozc-ut2 version information"
	eapply "${FILESDIR}/${PN}-add-ut2-info.patch"

	# Converting "ba-jonn", UT2 release date is also printed
	sed -i -e 's/\(GetMozcVersion()\);/\1 + ".'"${UT2_REL}"'";/g' \
		rewriter/version_rewriter.cc \
		|| die "Failed to add ut2 info to Mozc version_rewriter"

	# Add UT2 information to Mozc's about_dialog
	# e.g. when you execute "/usr/lib/mozc/mozc_tool -mode about_dialog"
	if use qt5 ; then
		sed -i -e \
			"s_UTr_/ release date: ${UT2_REL}_g" \
			"${S}/gui/about_dialog/about_dialog.ui" \
			"${S}/gui/about_dialog/about_dialog_en.ts" \
			"${S}/gui/about_dialog/about_dialog_ja.ts" \
			|| die "Failed to add ut info to Mozc about_dialog"
		"/usr/$(get_libdir)/qt5/bin/lrelease" -silent \
			"${S}/gui/about_dialog/about_dialog_en.ts"
		"/usr/$(get_libdir)/qt5/bin/lrelease" -silent \
			"${S}/gui/about_dialog/about_dialog_ja.ts" \
			|| die "Failed to recompile translation file"
	fi

	# For running UT2 scripts ############
	cd "${UT2_S}/src"

	ebegin "Filtering the original dictionaries"
	for n in $(seq 0 9) ; do
		ruby filter-mozc-entries.rb \
			"${S}"/data/dictionary_oss/dictionary0${n}.txt || die &
		if [ $(((${n}+1)%($(nproc)-1))) -eq 0 ] ; then wait ; fi
	done
	wait
	eend

	rm "${S}"/data/dictionary_oss/dictionary*.txt
	for fn in "${S}"/data/dictionary_oss/*.txt.filt ; do
	   mv $fn ${fn%%.txt.filt}.txt;
	done
	cat "${S}"/data/dictionary_oss/dictionary*.txt > mozcdict
	einfo "Removing duplicates"
	ruby remove-mozc-duplicates.rb mozcdict || die
	mv mozcdict.remdup mozcdict
	cp "${S}/data/dictionary_oss/id.def" id.def \
		|| die "Failed to copy hinshi ID"

	(
		ebegin "Generating zip code dictionary"
		cd ../chimei/
		cp "${WORKDIR}"/*.CSV ./
		cp "${S}/dictionary/gen_zip_code_seed.py" ./
		ruby modify-zipcode.rb KEN_ALL.CSV \
			|| die "Failed to generate zip code dictionary"
		#ruby get-chimei-entries.rb KEN_ALL.CSV.modzip \
		#	|| die "Failed to generate chimei.txt"
		cp "${S}/dictionary/gen_zip_code_seed.py" ./
		cp "${S}/dictionary/zip_code_util.py" ./
		sed -i "s/from dictionary import zip_code_util/import zip_code_util/g" \
			gen_zip_code_seed.py
		"${PYTHON}" gen_zip_code_seed.py --zip_code=KEN_ALL.CSV.modzip \
			--jigyosyo=JIGYOSYO.CSV \
			>> "${UT2_S}/src/zipcode.costs" \
				|| die "Failed to generate zip code dictionary"
		ruby get-chimei-costs.rb KEN_ALL.CSV.modzip || die
		eend
	)

	ebegin "Merging additional dictionaries"
	for dn in alt-cannadic chimei edict ekimei hatena neologd skk-jisyo ; do
		cat ../"${dn}"/*.hits >> jawikihits_all || die
	done
	cat ../jinmei/*.hits.modhits >> jawikihits_all || die
	
	if use nicodic ; then
		cat ../niconico/niconico.hits >> jawikihits_all || die
	fi
	eend

	einfo "Changing mozcdic order"
	ruby change-mozcdic-order-to-utdic-order.rb mozcdict \
		|| die "Failed to change mozcdic order"
	einfo "Converting jawikihits to costs"
	ruby convert-jawikihits-to-costs.rb jawikihits_all \
		|| die "Failed to convert jawikihits to costs"

	(
		cd ../ekimei
		einfo "Generating ekimei costs"
		ruby generate-ekimei-costs.rb ekimei.hits || die
	)

	cat mozcdict.utorder jawikihits_all.costs \
		../chimei/KEN_ALL.CSV.modzip.costs \
		../edict-katakana-english/kanaeng.costs \
		../ekimei/ekimei.costs > utdict.costs || die

	if use ejdic ; then
		cat ../wordnet-ejdic/wordnet-ejdic.costs >> utdict.costs || die
	fi
	eend

	einfo "Splitting new words and adding IDs"
	ruby split-new-words-and-add-id.rb utdict.costs || die
	mv utdict.costs.new utdict.costs

	einfo "Adding mozcdic-ut2 to the official Mozc source"
	cat utdict.costs zipcode.costs \
		>> "${S}/data/dictionary_oss/dictionary00.txt" \
		 || die "Failed to copy mozcdic-ut to official Mozc source"

	# Go back to the default directory
	cd "${S}"
}
