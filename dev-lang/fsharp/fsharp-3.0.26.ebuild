# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

USE_DOTNET="net40"

inherit autotools mono

DESCRIPTION="The F# Compiler"
HOMEPAGE="https://github.com/fsharp/fsharp"
SRC_URI="https://github.com/fsharp/fsharp/archive/${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

MAKEOPTS="-j1"
DEPEND="dev-lang/mono"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

pkg_postinst() {
	#trick older software to use fsharpc instead fsc
	dosym /usr/bin/fsharpc /usr/bin/fsc
	chmod 666 /etc/mono/registry/last-btime
}
