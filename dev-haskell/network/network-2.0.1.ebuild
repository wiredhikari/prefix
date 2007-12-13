# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/network/network-2.0.1.ebuild,v 1.6 2007/12/13 05:48:45 dcoutts Exp $

EAPI="prefix"

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

GHC_PV=6.6.1

DESCRIPTION="Haskell network library"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://www.haskell.org/ghc/dist/${GHC_PV}/ghc-${GHC_PV}-src-extralibs.tar.bz2"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~ia64 ~x86 ~x86-macos"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${PN}"

src_unpack() {
	unpack "${A}"
	cabal-mksetup
}
