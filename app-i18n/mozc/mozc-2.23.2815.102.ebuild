# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# Mozc doesn't support Python 3 yet
PYTHON_COMPAT=( python2_7 )

inherit elisp-common git-r3 multilib multiprocessing python-single-r1 \
	python-utils-r1 toolchain-funcs

DESCRIPTION="Mozc - a Japanese Input Method Editor designed for multi-platform"
HOMEPAGE="https://github.com/google/mozc"

MOZC_REV="afb03dd"
FCITX_PATCH_VER="2.23.2815.102.1"
UIM_PATCH_REV="c979f12"

MOZC_URI="https://github.com/google/mozc.git"
FCITX_PATCH_URI="http://download.fcitx-im.org/fcitx-mozc/fcitx-mozc-${FCITX_PATCH_VER}.patch"
UIM_PATCH_URI="https://github.com/e-kato/macuim.git"

EGIT_REPO_URI=${MOZC_URI}
EGIT_COMMIT=${MOZC_REV}
SRC_URI="fcitx? ( ${FCITX_PATCH_URI} )"

# Mozc: BSD, dictionary_oss: ipadic and public-domain, unicode: unicode,
# zinnia: BSD, usagedic: BSD-2, GYP: BSD, Mozc Fcitx: BSD, MacUIM: BSD,
# GMOCK: BSD, GTEST: BSD. IPAfont is in repo, but not used
LICENSE="BSD BSD-2 ipadic public-domain unicode"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs fcitx ibus +qt5 renderer tomoe uim"
REQUIRED_USE="|| ( emacs fcitx ibus uim )
	tomoe? ( qt5  )"

COMMON_DEPEND="${PYTHON_DEPS}
	!!app-i18n/mozc-ut2
	!!app-i18n/mozc-neologd-ut
	dev-libs/glib:2
	x11-libs/libXfixes
	x11-libs/libxcb
	emacs? ( virtual/emacs )
	fcitx? ( app-i18n/fcitx:4 )
	ibus? ( >=app-i18n/ibus-1.4.1 )
	qt5? ( dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		app-i18n/zinnia	)
	renderer? ( x11-libs/gtk+:2 )
	uim? ( app-i18n/uim )"
DEPEND="${COMMON_DEPEND}
	dev-util/ninja
	virtual/pkgconfig
	fcitx? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEPEND}
	qt5? ( !tomoe? ( app-i18n/tegaki-zinnia-japanese )
		tomoe? ( app-i18n/zinnia-tomoe ) )"

S="${WORKDIR}/${P}/src"
RESTRICT="mirror test"

BUILDTYPE=${BUILDTYPE:-Release}

SITEFILE="50${PN}-gentoo.el"

DOCS=( "${S%/src}/AUTHORS" "${S%/src}/CONTRIBUTING.md"
	"${S%/src}/CONTRIBUTORS" "${S%/src}/README.md"
	"${S%/src}/docs/about_branding.md" "${S%/src}/docs/release_history.md"
	"${S%/src}/docs/design_doc" )

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
		eapply -p2 "${DISTDIR}/$(basename ${FCITX_PATCH_URI})"
	fi

	if use uim ; then
		rm -rf unix/uim/
		cp -r "${WORKDIR}/macuim/Mozc/uim" "${S}/unix/"
		eapply -p0 "${WORKDIR}/macuim/Mozc/mozc-kill-line.diff"
	fi

	# Fix GCC 8 build
	# https://github.com/google/mozc/pull/444/commits/82d38f9
	if tc-is-gcc && [ $(gcc-major-version) -ge 8 ]; then
		eapply -p2 "${FILESDIR}/mozc-2.23.2815.102-gcc8.patch"
	fi

	sed -i -e 's:<!(which clang):'"$(tc-getCC)"':' \
		-e 's:<!(which clang++):'"$(tc-getCXX)"':' \
		gyp/common.gypi || die

	sed -i -e "/RunOrDie..ninja/s:ja, :ja, '-j"$(makeopts_jobs)"', :" \
		build_mozc.py || die

	eapply_user
}

src_configure() {
	export GYP_DEFINES="compiler_target=$(tc-getCC) compiler_host=$(tc-getCC)"
	tc-export CC CXX AR AS RANLIB LD NM

	use fcitx && export GYP_DEFINES="${GYP_DEFINES}
		use_fcitx=YES
		use_fcitx5=NO"

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
