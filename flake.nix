{
  description = "dotfiles dev environment with formatters";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # `nix fmt` uses treefmt
      formatter = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.toml;
        in
        treefmtEval.config.build.wrapper
      );

      # `nix develop` drops into a shell with all formatters available
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.toml;
        in
        {
          default = pkgs.mkShell {
            packages = [
              treefmtEval.config.build.wrapper
              pkgs.shfmt
              pkgs.stylua
              pkgs.nixfmt-rfc-style
              pkgs.nodePackages.prettier
            ];
          };
        }
      );
    };
}
