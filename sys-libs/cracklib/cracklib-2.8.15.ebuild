# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/cracklib/cracklib-2.8.15.ebuild,v 1.9 2010/04/01 17:24:35 armin76 Exp $

inherit eutils toolchain-funcs multilib libtool autotools

MY_P=${P/_}
DESCRIPTION="Password Checking Library"
HOMEPAGE="http://sourceforge.net/projects/cracklib"
SRC_URI="mirror://sourceforge/cracklib/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos ~m68k-mint"
IUSE="nls python"

DEPEND="python? ( <dev-lang/python-3 )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	# workaround #195017
	if has unmerge-orphans ${FEATURES} && has_version "<${CATEGORY}/${PN}-2.8.10" ; then
		eerror "Upgrade path is broken with FEATURES=unmerge-orphans"
		eerror "Please run: FEATURES=-unmerge-orphans emerge cracklib"
		die "Please run: FEATURES=-unmerge-orphans emerge cracklib"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.8.13-python-linkage.patch #246747
	sed -i '/PYTHON/s:\(print\) \([^"]*\):\1(\2):' configure #302908

	epatch "${FILESDIR}"/${PN}-2.8.12-interix.patch
	epatch "${FILESDIR}"/${P}-nls.patch

	AT_M4DIR="m4" eautoreconf # need new libtool for interix
	elibtoolize #269003
}

src_compile() {
	econf \
		--with-default-dict='$(libdir)/cracklib_dict' \
		$(use_enable nls) \
		$(use_with python) \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	rm -r "${ED}"/usr/share/cracklib

	# move shared libs to /
	gen_usr_ldscript -a crack

	insinto /usr/share/dict
	doins dicts/cracklib-small || die "word dict"

	dodoc AUTHORS ChangeLog NEWS README*
}

pkg_postinst() {
	if [[ ${ROOT} == "/" ]] ; then
		ebegin "Regenerating cracklib dictionary"
		create-cracklib-dict "${EPREFIX}"/usr/share/dict/* > /dev/null
		eend $?
	fi
}
