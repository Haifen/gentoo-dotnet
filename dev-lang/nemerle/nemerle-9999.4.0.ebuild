# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit mono git-2

DESCRIPTION="A hybrid programming language for .NET / Mono platforms"
HOMEPAGE="http://www.nemerle.org/"

SRC_URI=""

EGIT_REPO_URI="git://github.com/rsdn/nemerle.git"

LICENSE="BSD"
SLOT="4.0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">dev-lang/mono-2.11.3"
RDEPEND="${DEPEND}"

src_configure() { :; }

src_compile() {
	elog "Nemerle sources compiling : "
	xbuild NemerleAll-Mono.nproj /t:Stage1 /p:Configuration=Release /tv:4.0 /p:TargetFrameworkVersion=v"${SLOT}"
}

src_install()
{
	elog "Installing libraries"
	insinto "/usr/$(get_libdir)/mono/${SLOT}/${PN}"
	doins bin/Release/mono-3.5/Stage1/*.dll || die "installing libraries failed"
	elog "Registering libraries to egac"
	local nemerledll=bin/Release/mono-3.5/Stage1/Nemerle.dll
	egacinstall "${nemerledll}" \
		|| die "couldn't install ${nemerledll} in the global assembly cache"
	local nemerlecompilerdll=bin/Release/mono-3.5/Stage1/Nemerle.Compiler.dll
	egacinstall "${nemerlecompilerdll}" \
		|| die "couldn't install ${nemerlecompilerdll} in the global assembly cache"
	local nemerlemacrosdll=bin/Release/mono-3.5/Stage1/Nemerle.Macros.dll
	egacinstall "${nemerlemacrosdll}" \
		|| die "couldn't install ${nemerlemacrosdll} in the global assembly cache"
	elog "Installing ncc"
	dodoc README AUTHORS INSTALL NEWS
	into /usr
	doins bin/Release/mono-3.5/Stage1/ncc.exe
}

pkg_postinst() {
	echo "mono /usr/$(get_libdir)/mono/${PN}/${SLOT}/ncc.exe \"\$@\"" > /usr/bin/ncc
	chmod 777 /usr/bin/ncc
}
