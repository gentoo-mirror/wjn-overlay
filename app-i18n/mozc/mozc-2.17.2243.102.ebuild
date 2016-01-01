# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# Mozc doesn't support Python 3 yet.
PYTHON_COMPAT=( python2_7 )

inherit elisp-common eutils git-r3 multilib multiprocessing python-single-r1 \
	toolchain-funcs

DESCRIPTION="Mozc - Japanese Input Method"
HOMEPAGE="https://github.com/google/mozc"

MOZC_REV="24662ba"
FCITX_PATCH_VER="2.17.2102.102.1"
UIM_PATCH_REV="0562676"

MOZC_URI="https://github.com/google/mozc.git"
FCITX_PATCH_URI="http://download.fcitx-im.org/fcitx-mozc/fcitx-mozc-${FCITX_PATCH_VER}.patch"
UIM_PATCH_URI="https://github.com/e-kato/macuim.git"

EGIT_REPO_URI=${MOZC_URI}
EGIT_COMMIT=${MOZC_REV}
SRC_URI="fcitx? ( ${FCITX_PATCH_URI} )"

# Mozc: BSD, dictionary_oss: ipadic and public-domain, unicode: unicode,
# zinnia: BSD, usagedic: BSD-2, GYP: BSD, Mozc Fcitx: BSD, MacUIM: BSD,
# GMOCK: Boost-1.0, GTEST: BSD. IPAfont is in repo, but not used.
LICENSE="BSD BSD-2 ipadic public-domain unicode test? ( Boost-1.0 )"
SLOT="0"
KEYWORDS=""
IUSE="clang emacs fcitx ibus +qt4 renderer -test tomoe uim"
REQUIRED_USE="|| ( emacs fcitx ibus uim )
	tomoe? ( qt4 )"

COMMON_DEPEND="${PYTHON_DEPS}
	!app-i18n/mozc-ut
	dev-libs/glib:2
	x11-libs/libXfixes
	x11-libs/libxcb
	emacs? ( virtual/emacs )
	fcitx? ( app-i18n/fcitx )
	ibus? ( >=app-i18n/ibus-1.4.1 )
	qt4? ( dev-qt/qtgui:4 )
	renderer? ( x11-libs/gtk+:2 )
	uim? ( app-i18n/uim )"
DEPEND="${COMMON_DEPEND}
	dev-util/ninja
	dev-vcs/git
	>=sys-libs/zlib-1.2.8
	virtual/pkgconfig
	clang? ( >=sys-devel/clang-3.4 )
	fcitx? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEPEND}
	qt4? ( !tomoe? ( app-i18n/tegaki-zinnia-japanese )
		tomoe? ( app-i18n/zinnia-tomoe ) )"

S="${WORKDIR}/${P}/src"

RESTRICT="mirror"
use test || RESTRICT="${RESTRICT} test"

BUILDTYPE=${BUILDTYPE:-Release}

SITEFILE="50${PN}-gentoo.el"

DOCS=( "${WORKDIR}/${P}/AUTHORS" "${WORKDIR}/${P}/CONTRIBUTING.md"
	"${WORKDIR}/${P}/CONTRIBUTORS" "${WORKDIR}/${P}/README.md"
	"${WORKDIR}/${P}/doc/about_branding.md"
	"${WORKDIR}/${P}/doc/release_history.md"
	"${WORKDIR}/${P}/doc/design_doc" )

src_unpack() {
	git-r3_fetch ${MOZC_URI} ${MOZC_REV} mozc
	git-r3_checkout ${MOZC_URI} "${S%/src}" mozc

	if use uim ; then
		git-r3_fetch ${UIM_PATCH_URI} ${UIM_PATCH_REV} macuim
		git-r3_checkout ${UIM_PATCH_URI} "${WORKDIR}/macuim" macuim
	fi
}

src_prepare() {
	if use fcitx ; then
		rm -rf unix/fcitx/
		EPATCH_OPTS="-p2" epatch "${DISTDIR}/$(basename ${FCITX_PATCH_URI})"
	fi

	if use uim ; then
		rm -rf unix/uim/
		cp -r "${WORKDIR}/macuim/Mozc/uim" "${S}/unix/"
		epatch "${FILESDIR}/${PN}-macuim-rename-initgoogle.patch"
		epatch "${FILESDIR}/mozc-kill-line.diff"
	fi

	if ! use clang ; then
		sed -i -e "s/<!(which clang)/$(tc-getCC)/" \
			-e "s/<!(which clang++)/$(tc-getCXX)/" \
			gyp/common.gypi || die
	fi
}

src_configure() {
	local myconf="--server_dir=/usr/$(get_libdir)/mozc"

	if use clang ; then
		export GYP_DEFINES="compiler_target=clang compiler_host=clang"
	else
		export GYP_DEFINES="compiler_target=gcc compiler_host=gcc"
	fi

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

	if use emacs ; then
		dobin "out_linux/${BUILDTYPE}/mozc_emacs_helper"
		elisp-install ${PN} unix/emacs/*.{el,elc}
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${PN}
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
			filename=$(basename ${mofile})
			lang=${filename/.mo/}
			insinto "/usr/share/locale/${lang}/LC_MESSAGES/"
			newins "${mofile}" fcitx-mozc.mo
		done
	fi

	if use ibus ; then
		exeinto /usr/libexec
		newexe "out_linux/${BUILDTYPE}/ibus_mozc" ibus-engine-mozc
		sed -i "s_lib/ibus-mozc/ibus-engine-mozc_libexec/ibus-engine-mozc_g" \
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

		insinto /usr/share/uim/pixmaps
		newins data/images/unix/ime_product_icon_opensource-32.png mozc.png
		newins data/images/unix/ui-dictionary.png \
			mozc_tool_uim_dictionary_tool.png
		newins data/images/unix/ui-properties.png \
			mozc_tool_uim_config_dialog.png
		newins data/images/unix/ui-tool.png mozc_tool_uim_selector.png

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
