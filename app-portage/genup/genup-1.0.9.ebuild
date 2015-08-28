# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Update Portage tree, all installed packages, and kernel"
BASE_SERVER_URI="https://github.com/sakaki-"
HOMEPAGE="${BASE_SERVER_URI}/${PN}"
SRC_URI="${BASE_SERVER_URI}/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc"
IUSE="+buildkernel"

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}
	>=sys-libs/ncurses-5.9-r2
	>=app-portage/eix-0.29.3
	>=app-admin/perl-cleaner-2.7
	>=app-admin/python-updater-0.11
	>=app-portage/gentoolkit-0.3.0.8-r2
	amd64? ( buildkernel? ( >=sys-kernel/buildkernel-1.0.12 ) )
	>=app-shells/bash-4.2"

# ebuild function overrides
src_prepare() {
	# if the buildkernel use flag not set, set script variable accordingly
	if ! use buildkernel; then
		elog "buildkernel USE flag not selected - patching script accordingly."
		sed -i -e 's@USE_BUILDKERNEL=true@USE_BUILDKERNEL=false@g' "${S}/${PN}" || \
			die "Failed to patch script to reflect omitted buildkernel USE flag."
	elif use arm || use ppc; then
		ewarn "buildkernel USE flag not supported on this architecture"
		ewarn "please consider re-emerging with it turned off;"
		ewarn "you may still use genup, but must manually specify the"
		ewarn "--no-kernel-upgrade option each time, unless you do"
		ewarn "(otherwise, genup will fail)"
	fi
	epatch_user
}
src_install() {
	dosbin "${PN}"
	doman "${PN}.8"
	elog "Ensuring eix syncs overlays and updates the metadata cache, and that"
	elog "eix-update uses that cache, per:"
	elog "https://wiki.gentoo.org/wiki/Overlay#eix_integration"
	insinto "/etc"
	doins "${FILESDIR}/eix-sync.conf"
	insinto "/etc/eixrc"
	doins "${FILESDIR}/01-cache"
}
