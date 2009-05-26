# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-assistant/qt-assistant-4.5.1.ebuild,v 1.4 2009/05/24 12:09:20 klausman Exp $

EAPI=2
inherit qt4-build

DESCRIPTION="The assistant help module for the Qt toolkit"
SLOT="4"
KEYWORDS="~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="~x11-libs/qt-gui-${PV}[debug=]
	~x11-libs/qt-sql-${PV}[debug=,sqlite]
	~x11-libs/qt-webkit-${PV}[debug=]"
RDEPEND="${DEPEND} !<x11-libs/qt-4.4.0:4"

# Pixeltool isn't really assistant related, but it relies on
# the assistant libraries. And qdoc3 is needed by qt-creator...
QT4_TARGET_DIRECTORIES="tools/assistant tools/pixeltool tools/qdoc3"
QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
src/3rdparty/clucene/
tools/shared/fontpanel
include/
src/
doc/"

src_configure() {
	myconf="${myconf} -no-xkb  -no-fontconfig -no-xrender -no-xrandr
		-no-xfixes -no-xcursor -no-xinerama -no-xshape -no-sm -no-opengl
		-no-nas-sound -no-dbus -iconv -no-cups -no-nis -no-gif -no-libpng
		-no-libmng -no-libjpeg -no-openssl -system-zlib -no-phonon
		-no-xmlpatterns -no-freetype -no-libtiff -no-accessibility
		-no-fontconfig -no-glib -no-opengl -no-qt3support -no-svg -no-gtkstyle"
	qt4-build_src_configure
}

src_install() {
	qt4-build_src_install
	insinto ${QTDOCDIR#${EPREFIX}}
	doins -r "${S}"/doc/qch/ || die "Installing qch documentation failed"
	dobin "${S}"/tools/qdoc3/qdoc3 || die "Installing qdoc3 failed"

	# install correct assistant icon, bug 241208
	dodir /usr/share/pixmaps/ || die "dodir failed"
	insinto /usr/share/pixmaps/ || die "insinto failed"
	doins tools/assistant/tools/assistant/images/assistant.png \
		|| die "doins failed"
	# Note: absolute image path required here!
	 make_desktop_entry /usr/bin/assistant Assistant \
	 	/usr/share/pixmaps/assistant.png 'Qt;Development;GUIDesigner' \
		|| die "make_desktop_entry failed"
}
