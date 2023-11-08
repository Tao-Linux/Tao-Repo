<p align="center">
<img src="https://github.com/Tao-Linux/Tao-ISO/blob/main/assets/Tao.svg?raw=true" width=25% height=25%>
</p>

<h1 align="center">Tao Linux Package Repository</h1>

<p align="center">A `pacman` package repository that contains Tao Linux-specific packages and AUR packages needed in the Tao Linux live environment</p>

<p align="center">
<a href="https://www.gnu.org/licenses/gpl-3.0.en.html"><img alt="GPLv3 License" src="https://img.shields.io/badge/License-GPLv3-red.svg"></a>
</p>

## Installation
The Tao repositories *should* already be included by default in Tao Linux. If installing this on another Arch-based distro, however, simply add these lines to /etc/pacman.conf:

```
[Tao-Repo]
SigLevel = Optional DatabaseOptional
Server = https://raw.githubusercontent.com/Tao-Linux/$repo/main/$arch
```

Then just run `sudo pacman -Syyu`. Make sure there are 2 (two) y's in -Syyu! After that, you should be able to install any package from the repo with `pacman` as you would with any package from the official repos.

## PKGBUILDs
The PKGBUILD files for the packages in this repository are either:
- from the AUR, in which case you can find their links in the Acknowledgements section below, or
- packaged by the Tao maintainers, in which case you can find the PKGBUILD as a repository in the organization with the same name as the package appended with "-PKGBUILD"; for example, `Tao-Linux/lsb-release-Tao-PKGBUILD`.

## Acknowledgements
The following packages were taken from the AUR - check them out!
- [bspwm-git](https://aur.archlinux.org/packages/bspwm-git)
- [calamares](https://aur.archlinux.org/packages/calamares)
- [catppuccin-gtk-theme-mocha](https://aur.archlinux.org/packages/catppuccin-gtk-theme-mocha)
- [ckbcomp](https://aur.archlinux.org/packages/ckbcomp)
- [hyfetch-git](https://aur.archlinux.org/packages/hyfetch-git)
- [iwgtk](https://aur.archlinux.org/packages/iwgtk)
- [lightdm-settings](https://aur.archlinux.org/packages/lightdm-settings)
- [lightly-git](https://aur.archlinux.org/packages/lightly-git)
- [mkinitcpio-openswap](https://aur.archlinux.org/packages/mkinitcpio-openswap)
- [mpdevil](https://aur.archlinux.org/packages/mpdevil)
- [papirus-folders-catppucin-git](https://aur.archlinux.org/packages/papirus-folders-catppuccin-git)
- [paru](https://aur.archlinux.org/packages/paru)
- [qview](https://aur.archlinux.org/packages/qview)
- [sleepyneko-git](https://aur.archlinux.org/packages/sleepyneko-git)
- [sxhkd-git](https://aur.archlinux.org/packages/sxhkd-git)
- [xinit-xsession](https://aur.archlinux.org/packages/xinit-xsession)

## License
This repository is licensed under the [GPLv3 License](https://www.gnu.org/licenses/gpl-3.0.en.html), but that does not mean all software in this repo is too. Licenses for other software included in the distribution (i.e. the software in this repository) are usually found within the files provided by their respective packages. If you have found that Tao has violated any licenses or copyrights, please don't hesitate to open an issue on the repository/repositories that do so and we will do our best to respond in a timely manner.
