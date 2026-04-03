# Packages

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
