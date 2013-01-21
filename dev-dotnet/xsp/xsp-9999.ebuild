# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

USE_DOTNET="net35 net40 net45"
PATCHDIR="${FILESDIR}/2.2/"

inherit eutils go-mono mono user git-2 autotools-utils

DESCRIPTION="XSP is a small web server that can host ASP.NET pages"
HOMEPAGE="http://www.mono-project.com/ASP.NET"

LICENSE="MIT"
SLOT="0"
KEYWORDS="" #~amd64 ~ppc ~x86
IUSE="doc test"

RDEPEND="dev-db/sqlite:3"
DEPEND="${RDEPEND}"

AUTOTOOLS_AUTORECONF=yes
#AUTOTOOLS_IN_SOURCE_BUILD=1

ACLOCAL_AMFLAGS="-I build/m4/shamrock -I build/m4/shave"

src_prepare() {
	epatch "${FILESDIR}/tmpfix.patch"
	autotools-utils_src_prepare
}

#TODO: FIX
src_configure() {
	myeconfargs=("--enable-maintainer-mode")
	use test && myeconfargs+=("--with_unit_tests")
	use doc && myeconfargs+=("--doc")
	autotools-utils_src_configure
}

#TODO: FIX
src_compile() {
    autotools-utils_src_compile --gnu --add-missing --force --copy
}

pkg_preinst() {
	enewgroup aspnet
	# Give aspnet home dir of /tmp since it must create ~/.wapi
	enewuser aspnet -1 -1 /tmp aspnet
}

src_install() {
	mv_command="cp -ar" go-mono_src_install
	newinitd "${PATCHDIR}"/xsp.initd xsp
	newinitd "${PATCHDIR}"/mod-mono-server-r1.initd mod-mono-server
	newconfd "${PATCHDIR}"/xsp.confd xsp
	newconfd "${PATCHDIR}"/mod-mono-server.confd mod-mono-server

	keepdir /var/run/aspnet
}

pkg_postinst() {
	chown aspnet:aspnet /var/run/aspnet
}
