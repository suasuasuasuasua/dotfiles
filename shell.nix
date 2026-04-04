# Compatibility shim for `nix-shell` (non-flake workflow)
# Use `nix develop` (flake) or `nix-shell` (this file) to enter the dev env
{
  pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-25.11.tar.gz") { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    treefmt
    shfmt
    stylua
    nixfmt-rfc-style
    nodePackages.prettier
  ];
}
