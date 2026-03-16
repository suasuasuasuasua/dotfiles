# Compatibility shim for `nix-shell` (non-flake workflow)
# Use `nix develop` (flake) or `nix-shell` (this file) to enter the dev env
{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  packages = with pkgs; [
    treefmt
    shfmt
    stylua
    nixfmt-rfc-style
    nodePackages.prettier
  ];
}
