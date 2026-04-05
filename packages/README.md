# Packages

## brew

[brew](https://brew.sh) is a cross platform package manager primarily
targetting MacOS, but it is compatible with Linux.

```sh
# dumps to Brewfile-cask
brew bundle dump --force --describe --cask --file Brewfile-cask

# dumps to Brewfile
brew bundle dump --force --describe --formula

# to installed
brew bundle install

# or from the cask file
brew bundle install --fask Brewfile-cask
```

## cargo

[cargo](https://crates.io/) is the Rust package manger.

```sh
# list all installed packages
cargo install --list

# list all installed packages, then filter on version, then replace with '@'
cargo install --list | grep -oP '^\S+ v[\d.]+' | sed 's/ v/@/'

# install from the lockfile
xargs cargo install < cargo-installs.lock
```

## dnf

```sh
# lists the packages that the user asked for
dnf repoquery --userinstalled

# lists all packages that are installed on the system
dnf list --installed

# install from the lockfile
xargs dnf install -y cli.txt
```

## go

`golang` can install packages from any source like GitHub.

```sh
# list all installed packages under $HOME/go/bin
go version -m $HOME/go/bin/* | grep '^\s*path' | awk '{print $2}'

# dump to a lockfile
go version -m $HOME/go/bin/* | grep -E '^\s*mod\s' | awk '{print $2 "@" $3}' > go-installs.lock
```
