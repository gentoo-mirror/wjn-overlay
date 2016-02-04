# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit flag-o-matic qmake-utils

MY_P=QScintilla-gpl-${PV}

DESCRIPTION="A Qt port of Neil Hodgson's Scintilla C++ editor class"
HOMEPAGE="http://www.riverbankcomputing.com/software/qscintilla/intro"
SRC_URI="mirror://sourceforge/pyqt/${MY_P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="5/12"
KEYWORDS=""
IUSE="designer doc"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5
	designer? ( dev-qt/designer:5 )"
RDEPEND=${DEPEND}

S=${WORKDIR}/${MY_P}

# Rename libqtscintilla2 to libqt5scintilla2. This avoids conflicts against Qt4
PATCHES=( "${FILESDIR}/${PN}-qt5.patch" )
DOCS=( NEWS )

src_unpack() {
	default

	# Sub-slot sanity check
	local subslot=${SLOT#*/}
	local version=$(sed -nre 's:.*VERSION\s*=\s*([0-9\.]+):\1:p' "${S}"/Qt4Qt5/qscintilla.pro)
	local major=${version%%.*}
	if [[ ${subslot} != ${major} ]]; then
		eerror
		eerror "Ebuild sub-slot (${subslot}) does not match QScintilla major version (${major})"
		eerror "Please update SLOT variable as follows:"
		eerror "    SLOT=\"${SLOT%%/*}/${major}\""
		eerror
		die "sub-slot sanity check failed"
	fi
}

src_configure() {
	(
		cd Qt4Qt5
		eqmake5
	)
	
	if use designer ; then
		# prevent building against system version (bug 466120)
		append-cxxflags -I../Qt4Qt5
		append-ldflags -L../Qt4Qt5

		(
			cd designer-Qt4Qt5
			eqmake5
		)
	fi
}

src_compile() {
	(
		cd Qt4Qt5
		emake
	)
	
	if use designer; then
		(
			cd designer-Qt4Qt5
			emake
		)
	fi
}

src_install() {
	(
		cd Qt4Qt5 
		emake INSTALL_ROOT="${D}" install
	)

	if use designer ; then
		(
			cd designer-Qt4Qt5
			emake INSTALL_ROOT="${D}" install
		)
	fi

	einstalldocs

	if use doc; then
		docinto html
		dodoc -r doc/html-Qt4Qt5/*
	fi
}
