# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activeresource/activeresource-2.3.3.ebuild,v 1.1 2009/07/22 06:44:31 graaff Exp $

inherit ruby gems
USE_RUBY="ruby18 ruby19"

DESCRIPTION="Think Active Record for web resources.."
HOMEPAGE="http://rubyforge.org/projects/activeresource/"

LICENSE="MIT"
SLOT="2.3"
KEYWORDS="~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.6
	~dev-ruby/activesupport-2.3.3"
RDEPEND="${DEPEND}"
