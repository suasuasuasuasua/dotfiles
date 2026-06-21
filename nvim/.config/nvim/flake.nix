{
  description = "justinhoang's neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    # fork of sindrets/diffview.nvim; not in nixpkgs
    "plugins-diffview-plus" = {
      url = "github:dlyongemallo/diffview-plus.nvim";
      flake = false;
    };

    # alexghergh's neovim-native tmux navigation; not in nixpkgs
    "plugins-nvim-tmux-navigation" = {
      url = "github:alexghergh/nvim-tmux-navigation";
      flake = false;
    };

    # nixpkgs 26.05 snapshot predates mini.input; track upstream directly
    "plugins-mini-nvim" = {
      url = "github:echasnovski/mini.nvim";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixCats,
      ...
    }@inputs:
    let
      inherit (nixCats) utils;
      luaPath = ./.;
      forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;

      dependencyOverlays = [
        # makes pkgs.neovimPlugins.<name> available for non-nixpkgs inputs
        (utils.standardPluginOverlay inputs)
      ];

      categoryDefinitions =
        {
          pkgs,
          settings,
          categories,
          extra,
          name,
          ...
        }@packageDef:
        {
          # Tools placed on $PATH inside the nvim wrapper (replaces mason)
          lspsAndRuntimeDeps = {
            general = with pkgs; [
              ast-grep
              fd
              ripgrep
              stylua
            ];
            lua = with pkgs; [ lua-language-server ];
            nix = with pkgs; [ nil ];
            c = with pkgs; [ clang-tools ];
            go = with pkgs; [
              gopls
              gotools
              go-tools
            ];
            python = with pkgs; [ python3Packages.python-lsp-server ];
            typst = with pkgs; [ tinymist ];
            dap = with pkgs; [
              delve
              lldb
              python3Packages.debugpy
            ];
          };

          startupPlugins = {
            general = with pkgs.vimPlugins; [
              pkgs.neovimPlugins.mini-nvim
              friendly-snippets
              conform-nvim
              (nvim-treesitter.withPlugins (
                p: with p; [
                  bash
                  c
                  diff
                  html
                  lua
                  luadoc
                  markdown
                  markdown-inline
                  query
                  vim
                  vimdoc
                ]
              ))
              grug-far-nvim
              guess-indent-nvim
              lazygit-nvim
              neogen
              nvim-bqf
              pkgs.neovimPlugins.nvim-tmux-navigation
              nvim-ufo
              promise-async
              overseer-nvim
              render-markdown-nvim
              tokyonight-nvim
              pkgs.neovimPlugins.diffview-plus
            ];

            dap = with pkgs.vimPlugins; [
              nvim-dap
              nvim-dap-ui
              nvim-nio
              nvim-dap-go
              nvim-dap-python
            ];

            # opt-in per packageDefinitions
            neorg = with pkgs.vimPlugins; [ neorg ];
            oil = with pkgs.vimPlugins; [ oil-nvim ];
          };
        };

      packageDefinitions = {
        nvim =
          { pkgs, name, ... }:
          {
            settings = {
              wrapRc = true;
              aliases = [ "vim" ];
            };
            categories = {
              general = true;
              lua = true;
              nix = true;
              c = true;
              go = true;
              python = true;
              typst = true;
              dap = true;
              # opt-in
              neorg = false;
              oil = false;
            };
          };
      };

      defaultPackageName = "nvim";
    in
    forEachSystem (
      system:
      let
        nixCatsBuilder = utils.baseBuilder luaPath {
          inherit
            nixpkgs
            system
            dependencyOverlays
            ;
        } categoryDefinitions packageDefinitions;
        defaultPackage = nixCatsBuilder defaultPackageName;
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = utils.mkAllWithDefault defaultPackage;
        devShells.default = pkgs.mkShell { packages = [ defaultPackage ]; };
        formatter = pkgs.writeShellApplication {
          name = "treefmt";
          runtimeInputs = with pkgs; [
            treefmt
            nixfmt-rfc-style
            stylua
          ];
          text = "exec treefmt \"$@\"";
        };
      }
    );
}
