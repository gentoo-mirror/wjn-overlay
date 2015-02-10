# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_7} )
inherit elisp-common eutils multilib multiprocessing python toolchain-funcs

DESCRIPTION="Mozc - Japanese Input Method"
HOMEPAGE="http://code.google.com/p/mozc/"

MOZC_REV="480"
PROTOBUF_VER="2.6.1"
FCITX_PATCH_VER="1.15.1834.102.1"
UIM_PATCH_REV="334"

MOZC_URI="http://mozc.googlecode.com/svn/trunk/src"
USAGEDICT_URI="http://japanese-usage-dictionary.googlecode.com/svn/trunk/usage_dict.txt"
PROTOBUF_URI="https://github.com/google/protobuf/releases/download/v${PROTOBUF_VER}/protobuf-${PROTOBUF_VER}.tar.bz2"
GYP_URI="http://gyp.googlecode.com/svn/trunk/"
FCITX_PATCH_URI="http://download.fcitx-im.org/fcitx-mozc/fcitx-mozc-${FCITX_PATCH_VER}.patch"
UIM_PATCH_URI="https://macuim.googlecode.com/svn/trunk/Mozc"

SRC_URI="
	${PROTOBUF_URI}
	${USAGEDICT_URI}
	fcitx? ( ${FCITX_PATCH_URI} )
	uim? ( ${UIM_PATCH_URI} )
	"

LICENSE="BSD ipadic public-domain unicode"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs fcitx ibus +qt4 renderer uim"
REQUIRED_USE="|| ( emacs fcitx ibus uim )"

RDEPEND="
	dev-libs/glib:2
	dev-libs/openssl
	x11-libs/libXfixes
	x11-libs/libxcb
	!app-i18n/mozc-ut
	emacs? ( virtual/emacs )
	fcitx? ( app-i18n/fcitx )
	ibus? ( >=app-i18n/ibus-1.4.1 )
	renderer? ( x11-libs/gtk+:2 )
	qt4? (
		dev-qt/qtgui:4
		app-i18n/zinnia
	)
	uim? ( app-i18n/uim )
	${PYTHON_DEPS}
	"
DEPEND="${RDEPEND}
	dev-vcs/subversion
	dev-util/ninja
	virtual/pkgconfig
	"

RESTRICT="test"

BUILDTYPE=${BUILDTYPE:-Release}

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	svn co -q ${MOZC_URI}@${MOZC_REV} "${S}"

	cd "${S}/third_party"
	unpack $(basename ${PROTOBUF_URI})
	mv protobuf-${PROTOBUF_VER} protobuf
	svn -q co ${GYP_URI} gyp
	
	use uim && svn co -q ${UIM_PATCH_URI}@${UIM_PATCH_REV} "${WORKDIR}/macuim"
}

src_prepare() {
	cd "${S}"
	
	mkdir -p third_party/japanese_usage_dictionary
	cp "${DISTDIR}/$(basename ${USAGEDICT_URI})" third_party/japanese_usage_dictionary/

	if use fcitx; then
		rm -rf unix/fcitx/
		EPATCH_OPTS="-p2" epatch "${DISTDIR}/$(basename ${FCITX_PATCH_URI})"
	fi

	if use uim; then
		rm -rf unix/uim/
		mv "${WORKDIR}/macuim/uim" "${S}/unix/"
		epatch "${WORKDIR}/macuim/mozc-kill-line.diff"
	fi
}

src_configure() {
	local myconf="--server_dir=/usr/$(get_libdir)/mozc"

	use ibus && GYP_DEFINES="${GYP_DEFINES} ibus_mozc_path=/usr/libexec/ibus-engine-mozc ibus_mozc_icon_path=/usr/share/ibus-mozc/product_icon.png"

	if ! use qt4 ; then
		myconf="${myconf} --noqt"
		GYP_DEFINES="${GYP_DEFINES} use_libzinnia=0"
	fi

	use renderer || GYP_DEFINES="${GYP_DEFINES} enable_gtk_renderer=0"

	"${PYTHON}" build_mozc.py gyp "${myconf}" "gyp failed" || die
}

src_compile() {
	tc-export CC CXX AR AS RANLIB LD

	local my_makeopts=$(makeopts_jobs)
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

	"${PYTHON}" build_mozc.py build_tools -c "${BUILDTYPE}" ${myjobs} || die
	"${PYTHON}" build_mozc.py build -c "${BUILDTYPE}" ${mytarget} ${myjobs} || die

	use emacs && elisp-compile unix/emacs/*.el
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

	if use emacs ; then
		dobin "out_linux/${BUILDTYPE}/mozc_emacs_helper"
		elisp-install ${PN} unix/emacs/*.{el,elc}
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${PN}
	fi

	if use fcitx; then
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
		sed -i "s_/usr/lib/ibus-mozc/ibus-engine-mozc_/usr/libexec/ibus-engine-mozc_g" \
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
		newins data/images/unix/ui-dictionary.png mozc_tool_uim_dictionary_tool.png
		newins data/images/unix/ui-properties.png mozc_tool_uim_config_dialog.png
		newins data/images/unix/ui-tool.png mozc_tool_uim_selector.png

		insinto /usr/share/uim
		(
			cd "${WORKDIR}/macuim/scm"
			for f in *.scm ; do
				doins "${f}"
			done
		)
	fi
}

pkg_postinst() {
	if use emacs ; then
		elisp-site-regen
		elog "You can use mozc-mode via LEIM (Library of Emacs Input Method)."
		elog "Write the following settings into your init file (~/.emacs.d/init.el"
		elog "or ~/.emacs) in order to use mozc-mode by default, or you can call"
		elog "\`set-input-method' and set \"japanese-mozc\" anytime you have loaded"
		elog "mozc.el"
		elog
		elog "  (require 'mozc)"
		elog "  (setq default-input-method \"japanese-mozc\")"
		elog "  (set-language-environment \"Japanese\")"
		elog
		elog "Having the above settings, just type C-\\ which is bound to"
		elog "\`toggle-input-method' by default."
	fi
	use uim && uim-module-manager --register mozc
}

pkg_postrm() {
	use emacs && elisp-site-regen
	use uim && uim-module-manager --unregister mozc
}

