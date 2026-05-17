# sway

## Quickstart

Install dependencies listed in `pkgs.txt`, then install `Iosevka Nerd Font` from nerd-fonts releases.

```sh
sudo dnf install $(cat pkgs.txt | tr '\n' ' ')
```

Symlink with stow:

```sh
stow sway
```
