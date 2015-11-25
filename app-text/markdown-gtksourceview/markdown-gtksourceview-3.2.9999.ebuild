# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_{3,4} )

inherit multilib python-r1

MY_PN="gedit-markdown"

DESCRIPTION="Extra support for Markdown in GtkSourceView and gedit"
HOMEPAGE="https://github.com/jpfleury/gedit-markdown"
SRC_URI="https://github.com/jpfleury/${MY_PN}/archive/master.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="3.0"
KEYWORDS=""
IUSE="gedit webkit"
REQUIRED_USE="webkit? ( gedit )"

DEPEND="app-arch/unzip"
RDEPEND="x11-libs/gtksourceview:${SLOT}
	gedit? ( ${PYTHON_DEPS}
		app-editors/gedit[python,${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}] )
	webkit? ( net-libs/webkit-gtk:3 )"

S="${WORKDIR}/${MY_PN}-master"

RESTRICT="mirror"

src_prepare() {
	if use webkit ; then
		sed -e 's_#!/usr/bin/python_#!/usr/bin/python3_' \
			-i plugins/markdown-preview/markdown-preview/__init__.py || die
	fi
}

src_compile() {
	# Due to install raw files, emake must be avoided.
	:
}

src_install() {
	insinto /usr/share/gtksourceview-${SLOT}/language-specs
	doins language-specs/markdown-extra.lang
	insinto /usr/share/gtksourceview-${SLOT}
	doins -r styles
	dodoc README.md
	dodoc -r doc

	if use gedit ; then
		insinto /usr/share/gedit/plugins/snippets
		doins snippets/markdown-extra.xml

		exeinto /usr/share/gedit/plugins/externaltools/tools
		doexe tools/export-to-html
	fi

	if use webkit ; then 
		newdoc config/gedit-markdown.ini gedit-markdown.ini.sample
		insinto /usr/$(get_libdir)/gedit/plugins
		doins plugins/markdown-preview/markdown-preview.plugin
		doins -r plugins/markdown-preview/markdown-preview
	fi
}

pkg_postinst() {
	if use webkit ; then
		elog 'For setting the preview plugin,'
		elog 'please install gedit-markdown.ini to ~/.config/'
		elog "There is a sample file in /usr/share/doc/${PF}/"
	fi
}
