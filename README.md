# Homies

Many thanks to Nicolas Mattia - this is a lightly customised fork of his repo:
https://github.com/nmattia/homies/

## Reproducible set of dotfiles and packages for Linux and macOS

### Install Nix

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

If it's a machine with a single user who installs packages, then the "Single User Installation" (the default) is the easiest to maintain. (The /nix folder has this user's ownership.) In a multi-admin host, the "Multi User Installation" is better, and NixOS is probably best. Refer to the Nix [manual](https://nixos.org/nix/manual/#chap-installation).

### Install our environment

```sh
# install from the latest main
nix-env -if https://github.com/cdacos/homies/tarball/main --remove-all
# make sure that the .bashrc is sourced
echo 'if [ -x "$(command -v bashrc)" ]; then $(bashrc); fi' >> ~/.bashrc
source ~/.bashrc
```

The homies will be available in all subsequent shells, including the
customizations (vim with my favorite plugins, tmux with my customized
configuration, etc). See the [introduction blog post][post] for an overview.

[post]: http://nmattia.com/posts/2018-03-21-nix-reproducible-setup-linux-macos.html

## How-To

Trying out the package set:

```sh
nix-shell --pure
```

Installing the package set:

```sh
nix-env -f default.nix -i --remove-all
```

Listing the currently installed packages:

```sh
nix-env -q
```

Listing the previous and current configurations:

```sh
nix-env --list-generations
```

Rolling back to the previous configuration:

```sh
nix-env --rollback
```

Deleting old configurations:

```sh
nix-env --delete-generations [3 4 9 | old | 30d]
```

Update packages:

```sh
niv update
```

## Tracking the upstream repo

```sh
git remote add upstream git@github.com:nmattia/homies.git
git fetch upstream
git rebase upstream/master
```