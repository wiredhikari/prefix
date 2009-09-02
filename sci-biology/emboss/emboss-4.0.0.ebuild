# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/emboss/emboss-4.0.0.ebuild,v 1.12 2009/08/31 21:41:26 ribosome Exp $

EAPI=1

inherit prefix

DESCRIPTION="The European Molecular Biology Open Software Suite - A sequence analysis package"
HOMEPAGE="http://emboss.sourceforge.net/"
SRC_URI="ftp://${PN}.open-bio.org/pub/EMBOSS/EMBOSS-${PV}.tar.gz"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~amd64-linux ~x86-linux ~ppc-macos"
IUSE="X png minimal"

DEPEND="X? ( x11-libs/libXt )
	png? (
		sys-libs/zlib
		media-libs/libpng
		>=media-libs/gd-1.8
	)
	!minimal? (
		sci-biology/primer3
		sci-biology/clustalw:1
	)
	!<dev-util/pscan-20000721-r1"

RDEPEND="${DEPEND}"

PDEPEND="!minimal? (
		sci-biology/aaindex
		sci-biology/cutg
		sci-biology/prints
		>=sci-biology/prosite-19.7
		>=sci-biology/rebase-601-r1
		sci-biology/transfac
	)"

S="${WORKDIR}/EMBOSS-${PV}"

src_compile() {
	EXTRA_CONF="--includedir=${ED}/usr/include/emboss"
	! use X && EXTRA_CONF="${EXTRA_CONF} --without-x"
	! use png && EXTRA_CONF="${EXTRA_CONF} --without-pngdriver"

	econf ${EXTRA_CONF} || die
	# Do not install the JEMBOSS component (the --without-java configure option
	# does not work). JEMBOSS will eventually be available as a separate package.
	sed -i -e 's/SUBDIRS = plplot ajax nucleus emboss test doc jemboss/SUBDIRS = plplot ajax nucleus emboss test doc/' \
			Makefile || die
	emake || die
}

src_install() {
	einstall || die "Failed to install program files."

	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS "${FILESDIR}"/README.Gentoo \
			|| die "Failed to install documentation."

	# Install env file for setting libplplot and acd files path.
	cp "${FILESDIR}"/22emboss "${T}"
	( cd "${T}" && epatch "${FILESDIR}"/22emboss-prefix.patch )
	eprefixify "${T}"/22emboss
	doenvd "${T}"/22emboss || die "Failed to install environment file."

	# Symlink preinstalled docs to /usr/share/doc.
	dosym /usr/share/EMBOSS/doc/manuals /usr/share/doc/${PF}/manuals || die
	dosym /usr/share/EMBOSS/doc/programs /usr/share/doc/${PF}/programs || die
	dosym /usr/share/EMBOSS/doc/tutorials /usr/share/doc/${PF}/tutorials || die
	dosym /usr/share/EMBOSS/doc/html /usr/share/doc/${PF}/html || die

	# Remove useless dummy files from the image.
	rm "${ED}"/usr/share/EMBOSS/data/{AAINDEX,PRINTS,PROSITE,REBASE}/dummyfile \
			|| die "Failed to remove dummy files."

	# Move the provided codon files to a different directory. This will avoid
	# user confusion and file collisions on case-insensitive file systems (see
	# bug #115446). This change is documented in "README.Gentoo".
	mv "${ED}"/usr/share/EMBOSS/data/CODONS \
			"${ED}"/usr/share/EMBOSS/data/CODONS.orig || \
			die "Failed to move CODON directory."

	# Move the provided restriction enzyme prototypes file to a different name.
	# This will avoid file collisions with future versions of rebase that will
	# install their own enzyme prototypes file (see bug #118832).
	mv "${ED}"/usr/share/EMBOSS/data/embossre.equ \
			"${ED}"/usr/share/EMBOSS/data/embossre.equ.orig || \
			die "Failed to move enzyme equivalence file."
}
