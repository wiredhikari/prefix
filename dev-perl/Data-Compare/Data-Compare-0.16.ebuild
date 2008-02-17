# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Compare/Data-Compare-0.16.ebuild,v 1.4 2007/07/05 15:30:09 armin76 Exp $

EAPI="prefix"

inherit perl-module

DESCRIPTION="compare perl data structures"
HOMEPAGE="http://search.cpan.org/~dcantrell/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DC/DCANTRELL/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/File-Find-Rule
	dev-perl/Scalar-Properties
	dev-lang/perl"
