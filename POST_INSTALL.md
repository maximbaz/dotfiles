## dotfiles

First thing you want to do after installation is configure your dotfiles. If you don't have your own dotfiles yet, fork [my repo](https://github.com/maximbaz/dotfiles) and clone your fork.

Make sure to grep for `maximbaz` and set your own username.

Once done, run `setup-*` scripts to finalize the installation.

## pacman

To use your own custom pacman repository (e.g. when using `aurutils`), you need to register your PGP key in pacman.

TLDR: `pacman-key --recv-keys <keyid> && pacman-key --lsign-key <keyid>`

For more details, consult Arch Wiki.
