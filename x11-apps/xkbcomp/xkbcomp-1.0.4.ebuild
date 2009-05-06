# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xkbcomp/xkbcomp-1.0.4.ebuild,v 1.2 2009/05/05 07:57:43 fauli Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular multilib

DESCRIPTION="compile XKB keyboard description"
KEYWORDS="~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libxkbfile"
DEPEND="${RDEPEND}"

src_install() {
	x-modular_src_install

	dodir usr/share/X11/xkb
	dosym ../../../bin/xkbcomp /usr/share/X11/xkb/xkbcomp

	# (#122214) We should create this directory here, since xkeyboard-config
	# and any other set of layouts will symlink to it.
	dodir /var/lib/xkb
	keepdir /var/lib/xkb
}
