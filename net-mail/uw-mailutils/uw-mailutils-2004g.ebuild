# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/uw-mailutils/uw-mailutils-2004g.ebuild,v 1.13 2007/08/02 17:34:12 uberlord Exp $

EAPI="prefix"

inherit eutils flag-o-matic

MY_P="imap-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Mail utilities from the UW"
HOMEPAGE="http://www.washington.edu/imap/"
SRC_URI="ftp://ftp.cac.washington.edu/imap/${MY_P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND="virtual/libc
	!<net-mail/uw-imap-2004g-r1
	!<mail-client/pine-4.64-r1"

src_unpack() {
	unpack ${A}
	chmod -R ug+w ${S}

	cd ${S}

	epatch ${FILESDIR}/${P}.patch || die "epatch failed"

	sed -i -e "s|\`cat \$C/CFLAGS\`|${CFLAGS}|g" \
		src/mailutil/Makefile \
		src/mtest/Makefile || die "sed failed patching Makefile CFLAGS."

	append-flags -fPIC
}

src_compile() {
	if [[ ${CHOST} == *-darwin* ]] ; then
		yes | make osx EXTRACFLAGS="${CFLAGS}" \
		    SPECIALS="SSLDIR=${EPREFIX}/etc/ssl SSLINCLUDE=${EPREFIX}/usr/include/openssl SSLLIB=${EPREFIX}/usr/lib" SSLTYPE=none || die
	else
		local port=slx
		use elibc_FreeBSD && port=bsf
		yes | make "${port}" EXTRACFLAGS="${CFLAGS}" SSLTYPE=none || die
	fi
}

src_install() {
	into /usr
	dobin mailutil/mailutil mtest/mtest
	doman src/mailutil/mailutil.1
}
