# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

CABAL_FEATURES="bin lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A static website compiler library"
HOMEPAGE="http://jaspervdj.be/hakyll"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE="+checkexternal +previewserver +watchserver"

RDEPEND=">=app-text/pandoc-1.14:=[profile?]
	>=dev-haskell/binary-0.5:=[profile?] <dev-haskell/binary-0.8:=[profile?]
	>=dev-haskell/blaze-html-0.5:=[profile?] <dev-haskell/blaze-html-0.9:=[profile?]
	>=dev-haskell/blaze-markup-0.5.1:=[profile?] <dev-haskell/blaze-markup-0.8:=[profile?]
	>=dev-haskell/cmdargs-0.10:=[profile?] <dev-haskell/cmdargs-0.11:=[profile?]
	>=dev-haskell/cryptohash-0.7:=[profile?] <dev-haskell/cryptohash-0.12:=[profile?]
	>=dev-haskell/data-default-0.4:=[profile?] <dev-haskell/data-default-0.6:=[profile?]
	>=dev-haskell/lrucache-1.1.1:=[profile?] <dev-haskell/lrucache-1.3:=[profile?]
	>=dev-haskell/mtl-1:=[profile?] <dev-haskell/mtl-2.3:=[profile?]
	>=dev-haskell/network-2.6:=[profile?] <dev-haskell/network-2.7:=[profile?]
	>=dev-haskell/network-uri-2.6:=[profile?] <dev-haskell/network-uri-2.7:=[profile?]
	>=dev-haskell/pandoc-citeproc-0.4:=[profile?] <dev-haskell/pandoc-citeproc-0.8:=[profile?]
	>=dev-haskell/parsec-3.0:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-haskell/random-1.0:=[profile?] <dev-haskell/random-1.2:=[profile?]
	>=dev-haskell/regex-base-0.93:=[profile?] <dev-haskell/regex-base-0.94:=[profile?]
	>=dev-haskell/regex-tdfa-1.1:=[profile?] <dev-haskell/regex-tdfa-1.3:=[profile?]
	>=dev-haskell/tagsoup-0.13.1:=[profile?] <dev-haskell/tagsoup-0.14:=[profile?]
	>=dev-haskell/text-0.11:=[profile?] <dev-haskell/text-1.3:=[profile?]
	>=dev-lang/ghc-7.4.1:=
	checkexternal? ( >=dev-haskell/http-conduit-2.1:=[profile?] <dev-haskell/http-conduit-2.2:=[profile?]
				>=dev-haskell/http-types-0.7:=[profile?] <dev-haskell/http-types-0.9:=[profile?] )
	previewserver? ( >=dev-haskell/fsnotify-0.1:=[profile?] <dev-haskell/fsnotify-0.2:=[profile?]
				>=dev-haskell/snap-core-0.6:=[profile?] <dev-haskell/snap-core-0.10:=[profile?]
				>=dev-haskell/snap-server-0.6:=[profile?] <dev-haskell/snap-server-0.10:=[profile?]
				>=dev-haskell/system-filepath-0.4.6:=[profile?] <=dev-haskell/system-filepath-0.5:=[profile?] )
	!previewserver? ( watchserver? ( >=dev-haskell/fsnotify-0.1:=[profile?] <dev-haskell/fsnotify-0.2:=[profile?]
						>=dev-haskell/system-filepath-0.4.6:=[profile?] <=dev-haskell/system-filepath-0.5:=[profile?] ) )
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( >=dev-haskell/hunit-1.2 <dev-haskell/hunit-1.3
		>=dev-haskell/quickcheck-2.4 <dev-haskell/quickcheck-2.9
		>=dev-haskell/test-framework-0.4 <dev-haskell/test-framework-0.9
		>=dev-haskell/test-framework-hunit-0.3 <dev-haskell/test-framework-hunit-0.4
		>=dev-haskell/test-framework-quickcheck2-0.3 <dev-haskell/test-framework-quickcheck2-0.4 )
"

src_prepare() {
	cabal_chdeps \
		'pandoc          >= 1.14    && < 1.15' 'pandoc             >= 1.14'
}

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag checkexternal checkexternal) \
		$(cabal_flag previewserver previewserver) \
		$(cabal_flag watchserver watchserver)
}
