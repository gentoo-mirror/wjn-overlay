# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit elisp-common eutils git-r3 multilib multiprocessing python-single-r1 \
	toolchain-funcs versionator

DESCRIPTION="Mozc Japanese Input Method with Additional Japanese dictionary"
HOMEPAGE="http://www.geocities.jp/ep3797/mozc_01.html"

MOZC_VER=$(get_version_component_range 1-$(get_last_version_component_index))
MOZC_REV="20c1c08"
MOZCUT_VER=$(get_version_component_range $(get_version_component_count))
PROTOBUF_REV="172019c"
# JSONCPP_REV="11086dd"
FCITX_PATCH_VER="2.16.2037.102.2"
UIM_PATCH_REV="2b3eff9"
GMOCK_REV="501"
GTEST_REV="700"

# We must clone Mozc by git to manage its versions.
# MOZC_URI="https://github.com/google/mozc.git"
EGIT_REPO_URI="https://github.com/google/mozc.git"
EGIT_COMMIT=${MOZC_REV}
EGIT_CHECKOUT_DIR="${WORKDIR}/mozcdic-ut-${MOZCUT_VER}/mozc_src"

USAGEDICT_URI="https://raw.githubusercontent.com/hiroyuki-komatsu/japanese-usage-dictionary/master/usage_dict.txt"
GYP_URI="https://chromium.googlesource.com/external/gyp.git"

# The dependency on protobuf version is near 2.5.0 (172019c).
# We should checkout this commit.
# See Mozc commit 444f8a7 https://github.com/google/mozc/commit/444f8a7
# PROTOBUF_URI="https://github.com/google/protobuf/releases/download/v${PROTOBUF_VER}/protobuf-${PROTOBUF_VER}.tar.bz2"
PROTOBUF_URI="https://github.com/google/protobuf.git"

#JSONCPP_URI="https://github.com/open-source-parsers/jsoncpp.git"
#FONTTOOLS_URI="https://github.com/behdad/fonttools.git"

MOZCUT_URI="mirror://sourceforge/mdk-ut/mozcdic-ut-${MOZCUT_VER}.tar.bz2"
FCITX_PATCH_URI="http://download.fcitx-im.org/fcitx-mozc/fcitx-mozc-${FCITX_PATCH_VER}.patch"
UIM_PATCH_URI="https://github.com/e-kato/macuim.git"

GMOCK_URI="http://googlemock.googlecode.com/svn/trunk"
GTEST_URI="http://googletest.googlecode.com/svn/trunk"

SRC_URI="${MOZCUT_URI}
	${USAGEDICT_URI}
	fcitx? ( ${FCITX_PATCH_URI} )"

# MAKE SURE:
# 	The licenses of nicodic as well as hatena-keyword are unknown.
# 	Therefore they can be all-rights-reserved.
LICENSE="BSD BSD-2 CC-BY-SA-3.0 GPL-2 all-rights-reserved ipadic public-domain
	unicode ejdic? ( wn-ja )  test? ( Boost-1.0 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
	>=dev-lang/ruby-2.0
	dev-util/ninja
	dev-vcs/git
	virtual/pkgconfig
	clang? ( >=sys-devel/clang-3.4 )
	test? ( dev-vcs/subversion )"
RDEPEND="${COMMON_DEPEND}
	qt4? ( app-i18n/tegaki-zinnia-japanese )"

use test || RESTRICT="test"

BUILDTYPE=${BUILDTYPE:-Release}

SITEFILE="50${PN%-ut}-gentoo.el"

pkg_pretend(){
	if use nicodic; then
		ewarn "WARNING:"
		ewarn "The author of Mozc UT recommends disabling its NICODIC feature,"
		ewarn "because the license of NICODIC isn't clear."
		ewarn "Are you sure to enable NICODIC feature?"
	fi
}

src_unpack() {
	unpack $(basename ${MOZCUT_URI})

	cd "${WORKDIR}/mozcdic-ut-${MOZCUT_VER}"

	rm -rf mozc_src && git-r3_src_unpack || die

	cd mozc_src/src && rm -rf .git

	cd third_party
	elog "Cloning Protobuf..."
	git clone -q ${PROTOBUF_URI} protobuf \
		&& ( cd protobuf && git checkout -q ${PROTOBUF_REV} && rm -rf .git )
	mkdir japanese_usage_dictionary
	cp "${DISTDIR}/$(basename ${USAGEDICT_URI})" japanese_usage_dictionary/

	cd "${WORKDIR}/mozcdic-ut-${MOZCUT_VER}" && ruby generate-mozc-tarball.rb \
		&& mv mozc_src/mozc-*.tar.bz2 ../ && rm -rf mozc_src/ || die

	# FIX BELOW:
	# 	These sed(s) are called in src_unpack, violate the Quality Assurance.
	use ejdic \
		&& sed -i 's/#EJDIC="true"/EJDIC="true"/g' \
			"${WORKDIR}/mozcdic-ut-${MOZCUT_VER}/generate-mozc-ut.sh"
	use nicodic \
		&& sed -i 's/#NICODIC="true"/NICODIC="true"/g' \
			"${WORKDIR}/mozcdic-ut-${MOZCUT_VER}/generate-mozc-ut.sh"
	./generate-mozc-ut.sh || die

	cd "${S}/third_party"
		elog "Cloning GYP..."
	git clone -q --depth 1 ${GYP_URI} gyp || die
#	elog "Cloning JsonCpp..."
#	git clone -q ${JSONCPP_URI} jsoncpp \
#		&& ( cd jsoncpp && git checkout -q ${JSONCPP_REV} ) || die
	if use test; then
		svn co -q ${GMOCK_URI}@${GMOCK_REV} gmock
		svn co -q ${GTEST_URI}@${GTEST_REV} gtest
	fi

	use uim && elog "Cloning MacUIM (UIM patch)..." \
		&& git clone -q ${UIM_PATCH_URI} "${WORKDIR}/macuim" \
		&& (cd "${WORKDIR}/macuim" && git checkout -q ${UIM_PATCH_REV} ) || die
}

src_prepare() {
	if ! use clang; then
		sed -i -e "s/<!(which clang)/$(tc-getCC)/" \
			-e "s/<!(which clang++)/$(tc-getCXX)/" \
			gyp/common.gypi || die
	fi

	if use fcitx; then
		rm -rf unix/fcitx/
		EPATCH_OPTS="-p2" epatch "${DISTDIR}/$(basename ${FCITX_PATCH_URI})"
	fi

	if use uim; then
		rm -rf unix/uim/
		cp -r "${WORKDIR}/macuim/Mozc/uim" "${S}/unix/"
		epatch "${WORKDIR}/macuim/Mozc/mozc-kill-line.diff"
	fi
}

src_configure() {
	if use clang; then
		local GYP_DEFINES="compiler_target=clang compiler_host=clang"
	else
		local GYP_DEFINES="compiler_target=gcc compiler_host=gcc"
	fi

	local myconf="--server_dir=/usr/$(get_libdir)/mozc"

	use ibus && GYP_DEFINES="${GYP_DEFINES} \
		ibus_mozc_path=/usr/libexec/ibus-engine-mozc \
		ibus_mozc_icon_path=/usr/share/ibus-mozc/product_icon.png"

	if ! use qt4 ; then
		myconf="${myconf} --noqt"
		GYP_DEFINES="${GYP_DEFINES} use_libzinnia=0 \
		zinnia_model_file=/usr/share/tegaki/models/zinnia/handwriting-ja.model"
	fi

	use renderer || GYP_DEFINES="${GYP_DEFINES} enable_gtk_renderer=0"

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

	use emacs && elisp-compile unix/emacs/*.el || die
}

src_test() {
	"${PYTHON}" build_mozc.py runtests -c Release
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
	dodoc "${WORKDIR}/mozcdic-ut-${MOZCUT_VER}/README"
	dodoc "${WORKDIR}/mozcdic-ut-${MOZCUT_VER}/AUTHORS"
	dodoc "${WORKDIR}/mozcdic-ut-${MOZCUT_VER}/COPYING"
	dodoc "${WORKDIR}/mozcdic-ut-${MOZCUT_VER}/ChangeLog"

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

	if use uim; then
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
