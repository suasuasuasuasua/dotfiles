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
            general = [
              pkgs.ast-grep
              pkgs.fd
              pkgs.ripgrep
              pkgs.stylua
            ];
            lua = [ pkgs.lua-language-server ];
            nix = [ pkgs.nil ];
            c = [ pkgs.clang-tools ];
            go = [
              pkgs.gopls
              pkgs.gotools
              pkgs.go-tools
            ];
            python = [ pkgs.python3Packages.python-lsp-server ];
            typst = [ pkgs.tinymist ];
            dap = [
              pkgs.delve
              pkgs.lldb
              pkgs.python3Packages.debugpy
            ];
          };

          startupPlugins = {
            general = [
              pkgs.neovimPlugins.mini-nvim
              pkgs.vimPlugins.friendly-snippets
              pkgs.vimPlugins.conform-nvim
              (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
                p.bash
                p.c
                p.diff
                p.html
                p.lua
                p.luadoc
                p.markdown
                p.markdown-inline
                p.query
                p.vim
                p.vimdoc
              ]))
              pkgs.vimPlugins.grug-far-nvim
              pkgs.vimPlugins.guess-indent-nvim
              pkgs.vimPlugins.lazygit-nvim
              pkgs.vimPlugins.neogen
              pkgs.vimPlugins.nvim-bqf
              pkgs.neovimPlugins.nvim-tmux-navigation
              pkgs.vimPlugins.nvim-ufo
              pkgs.vimPlugins.promise-async
              pkgs.vimPlugins.overseer-nvim
              pkgs.vimPlugins.render-markdown-nvim
              pkgs.vimPlugins.tokyonight-nvim
              pkgs.neovimPlugins.diffview-plus
            ];

            dap = [
              pkgs.vimPlugins.nvim-dap
              pkgs.vimPlugins.nvim-dap-ui
              pkgs.vimPlugins.nvim-nio
              pkgs.vimPlugins.nvim-dap-go
              pkgs.vimPlugins.nvim-dap-python
            ];

            # opt-in per packageDefinitions
            neorg = [ pkgs.vimPlugins.neorg ];
            oil = [ pkgs.vimPlugins.oil-nvim ];
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
          runtimeInputs = [
            pkgs.treefmt
            pkgs.nixfmt-rfc-style
            pkgs.stylua
          ];
          text = "exec treefmt \"$@\"";
        };
      }
    );
}
