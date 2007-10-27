# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/t1utils/t1utils-1.32.ebuild,v 1.8 2007/10/13 06:13:01 tgall Exp $

EAPI="prefix"

IUSE=""

DESCRIPTION="Type 1 Font utilities"
SRC_URI="http://www.lcdf.org/type/${P}.tar.gz"
HOMEPAGE="http://www.lcdf.org/type/#t1utils"
KEYWORDS="~amd64 ~ia64 ~ppc-macos ~x86"
SLOT="0"
LICENSE="BSD"

DEPEND="virtual/libc"

src_install () {
	einstall || die
	dodoc NEWS README
}
