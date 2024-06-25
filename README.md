# Genpi-tools Gentoo Overlay, formerly sakaki-tools

Overlay containing various utility ebuilds for Gentoo on EFI.

Required for the tutorial ["**Sakaki's EFI Install Guide**"](https://wiki.gentoo.org/wiki/Sakaki's_EFI_Install_Guide) on the Gentoo wiki.

## List of ebuilds

* **app-portage/showem** [source](https://github.com/sakaki-/showem)
  * Provides a simple utility script (**showem**(1)), which enables you to monitor the progress of a parallel **emerge**(1). A manpage is included.
* **sys-kernel/buildkernel** [source](https://github.com/sakaki-/buildkernel)
  * Provides a script (**buildkernel**(8)) to build a (stub EFI) kernel (with integral initramfs) suitable for booting from a USB key on UEFI BIOS PCs. Automatically sets the necessary kernel configuration parameters, including the command line, and signs the resulting kernel if possible (for secure boot). Has a interactive and non-interactive (batch) mode. Manpages for the script and its configuration file (_/etc/buildkernel.conf_) are included.
* **app-portage/genup** [source](https://github.com/sakaki-/genup)
  * Provides the **genup**(8) script, to simplify the process of keeping your Gentoo system up-to-date. **genup**(8) can automatically update the Portage tree, all installed packages, and kernel. Has interactive and non-interactive (batch) modes. A manpage is included.
* **sys-apps/coreboot-utils** [upstream](https://www.coreboot.org)
  * This package provides a few utilities from the coreboot project, specifically `ifdtool` to parse and modify flash dumps of Intel firmware and (on `amd64` only) `intelmetool` to query the status of the Intel Management Engine.
* **(eclass/)java-maven-pkg.eclass**
  * Provides an eclass to support building Maven pacakges from source. Use `mvn2ebuild` in place of `mvn` within a working Maven build tree, to create a 'starter' ebuild using this eclass.

## Installation

As of version >= 2.2.16 of Portage, **genpi-tools** is best installed (on Gentoo) via the [new plug-in sync system](https://wiki.gentoo.org/wiki/Project:Portage/Sync).
Full instructions are provided on the [Gentoo wiki](https://wiki.gentoo.org/wiki/Sakaki's_EFI_Install_Guide/Building_the_Gentoo_Base_System_Minus_Kernel#Preparing_to_Run_Parallel_emerges).

The following are short form instructions. If you haven't already installed **git**(1), do so first:

    # emerge --ask --verbose dev-vcs/git

Next, create a custom `/etc/portage/repos.conf` entry for the **genpi-tools** overlay, so Portage knows what to do. Make sure that `/etc/portage/repos.conf` exists, and is a directory. Then, fire up your favourite editor:

    # nano -w /etc/portage/repos.conf/genpi-tools.conf

and put the following text in the file:
```
[genpi-tools]

# Various utility ebuilds for Gentoo on EFI
# former  Maintainer: sakaki (sakaki@deciban.com) / now https://github.com/GenPi64/genpi-tools

location = /var/db/repos/genpi-tools
sync-type = git
sync-uri = https://github.com/GenPi64/genpi-tools.git
priority = 50
auto-sync = yes
```

Then run:

    # emaint sync --repo genpi-tools

If you are running on the stable branch by default, allow **~amd64** keyword files from this repository. Make sure that `/etc/portage/package.accept_keywords` exists, and is a directory. Then issue:

    # echo "*/*::genpi-tools ~amd64" >> /etc/portage/package.accept_keywords/genpi-tools-repo

Now you can install packages from the overlay. For example:

    # emerge --ask --verbose app-portage/genup

## Maintainers
*genpi Team
