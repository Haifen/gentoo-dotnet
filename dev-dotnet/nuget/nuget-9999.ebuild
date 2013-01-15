# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="https://git01.codeplex.com/nuget"

inherit git-2

DESCRIPTION="Nuget - .NET Package Manager"
HOMEPAGE="http://nuget.codeplex.com"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/mono"
RDEPEND="${DEPEND}"

src_prepare() {
	./build.sh
}

src_install() {
	elog "Installing libraries"
	insinto /usr/lib/mono/4.0/
	doins src/CommandLine/obj/Mono\ Release/NuGet.exe || die
	doins src/Core/obj/Mono\ Release/NuGet.Core.dll || die
}

pkg_postinst() {
	mozroots --import --sync --machine
	#mkdir /usr/share/.mono
	#cp -rf ~/.config/.mono/certs /usr/share/.mono/certs
	echo "mono /usr/lib/mono/4.0/NuGet.exe \"\$\@\"" > /usr/bin/nuget
	chmod 777 /usr/bin/nuget
}
