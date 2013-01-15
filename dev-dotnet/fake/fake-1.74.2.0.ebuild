# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit nuget

DESCRIPTION="FAKE - F# Make"
HOMEPAGE="http://nuget.org/packages/FAKE"
SRC_URI=""

LICENSE="MS-PL"
SLOT="0"
KEYWORDS="~amd46 ~x86"
IUSE=""

DEPEND="dev-lang/mono
dev-lang/fsharp"
RDEPEND="${DEPEND}"

#src_install() {
#	elog "Installing libraries"
#	insinto /usr/lib/mono/4.0/
#	doins build/FAKE.exe || die
#	doins build/FakeLib.dll || die
#}

#pkg_postinst() {
#	echo "mono /usr/lib/mono/4.0/FAKE.exe \"$@\"" > /usr/bin/fake
#	chmod 777 /usr/bin/fake
#}