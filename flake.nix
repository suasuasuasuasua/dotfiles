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

      # Shared treefmt config (Nix module — treefmt-nix does not read treefmt.toml)
      treefmtConfig = {
        projectRootFile = "flake.nix";

        # Formatters
        programs.shfmt = {
          enable = true;
          indent_size = 2;
        };
        programs.stylua.enable = true;
        programs.nixfmt-rfc-style.enable = true;
        programs.prettier.enable = true;

        # Restrict shfmt to bash only — zsh syntax is incompatible with shfmt
        settings.formatter.shfmt.includes = [
          "*.sh"
          "*.bash"
          "**/.bashrc"
        ];

        # Exclude submodule directories from all formatters
        settings.formatter.shfmt.excludes = [
          "vim/.config/vim/pack/**"
          "tmux/.config/tmux/plugins/**"
          "nvim/.config/nvim/**"
        ];
        settings.formatter.stylua.excludes = [
          "vim/.config/vim/pack/**"
          "tmux/.config/tmux/plugins/**"
          "nvim/.config/nvim/**"
        ];
        settings.formatter.nixfmt-rfc-style.excludes = [
          "vim/.config/vim/pack/**"
          "tmux/.config/tmux/plugins/**"
          "nvim/.config/nvim/**"
        ];
        settings.formatter.prettier.excludes = [
          "vim/.config/vim/pack/**"
          "tmux/.config/tmux/plugins/**"
          "nvim/.config/nvim/**"
        ];
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
          default = pkgs.mkShell {
            packages = [
              (treefmt-nix.lib.evalModule pkgs treefmtConfig).config.build.wrapper
            ];
          };
        }
      );
    };
}
