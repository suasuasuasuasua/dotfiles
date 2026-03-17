{
  description = "dotfiles dev environment with formatters";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
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

      # Shared treefmt config as a module function so pkgs is in scope
      treefmtConfig =
        { pkgs, ... }:
        let
          excludedSubmodulePaths = [
            "vim/.config/vim/pack/**"
            "tmux/.config/tmux/plugins/**"
            "nvim/.config/nvim/**"
          ];
        in
        {
          projectRootFile = "flake.nix";

          # Formatters
          programs.shfmt = {
            enable = true;
            indent_size = 2;
          };
          programs.stylua.enable = true;
          programs.nixfmt = {
            enable = true;
            package = pkgs.nixfmt-rfc-style;
          };
          programs.prettier.enable = true;

          # Restrict shfmt to bash only — zsh syntax is incompatible with shfmt
          settings.formatter.shfmt.includes = [
            "**/.bashrc"
            "*.bash"
            "*.sh"
            # "**/.zshrc"
            # "*.zsh"
          ];

          # Exclude submodule directories from all formatters
          settings.formatter.shfmt.excludes = excludedSubmodulePaths;
          settings.formatter.stylua.excludes = excludedSubmodulePaths;
          settings.formatter.nixfmt.excludes = excludedSubmodulePaths;
          settings.formatter.prettier.excludes = excludedSubmodulePaths;
        };
    in
    {
      # `nix fmt` uses treefmt
      formatter = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        (treefmt-nix.lib.evalModule pkgs treefmtConfig).config.build.wrapper
      );

      # `nix develop` drops into a shell with all formatters available
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = import ./shell.nix {
            inherit pkgs;
          };
        }
      );
    };
}
