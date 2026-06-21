{
  description = "justinhoang's neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    "plugins-diffview-plus" = {
      url = "github:dlyongemallo/diffview-plus.nvim";
      flake = false;
    };
    "plugins-nvim-tmux-navigation" = {
      url = "github:alexghergh/nvim-tmux-navigation";
      flake = false;
    };
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
      mkPython =
        pkgs:
        pkgs.python3.withPackages (ps: [
          ps.debugpy
          ps.pynvim
        ]);

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
        }:
        {
          # Tools placed on $PATH inside the nvim wrapper
          lspsAndRuntimeDeps = {
            general = [
              pkgs.ast-grep
              pkgs.fd
              (mkPython pkgs)
              pkgs.ripgrep
              pkgs.stylua
            ];
            lua = [ pkgs.lua-language-server ];
            nix = [ pkgs.nil ];
            c = [ pkgs.clang-tools ];
            go = [
              pkgs.go-tools
              pkgs.gopls
              pkgs.gotools
            ];
            python = [ pkgs.ty ];
            typst = [ pkgs.tinymist ];
            dap = [
              pkgs.delve
              pkgs.lldb
            ];
          };

          startupPlugins = {
            general = [
              pkgs.vimPlugins.conform-nvim
              pkgs.neovimPlugins.diffview-plus
              pkgs.vimPlugins.friendly-snippets
              pkgs.vimPlugins.grug-far-nvim
              pkgs.vimPlugins.guess-indent-nvim
              pkgs.vimPlugins.lazygit-nvim
              pkgs.neovimPlugins.mini-nvim
              pkgs.vimPlugins.neogen
              pkgs.vimPlugins.nvim-bqf
              pkgs.vimPlugins.nvim-lspconfig
              pkgs.neovimPlugins.nvim-tmux-navigation
              pkgs.vimPlugins.nvim-treesitter.withAllGrammars
              pkgs.vimPlugins.nvim-ufo
              pkgs.vimPlugins.overseer-nvim
              pkgs.vimPlugins.promise-async
              pkgs.vimPlugins.render-markdown-nvim
              pkgs.vimPlugins.tokyonight-nvim
            ];

            dap = [
              pkgs.vimPlugins.nvim-dap
              pkgs.vimPlugins.nvim-dap-go
              pkgs.vimPlugins.nvim-dap-python
              pkgs.vimPlugins.nvim-dap-ui
              pkgs.vimPlugins.nvim-nio
            ];
            # opt-in per packageDefinitions
            neorg = [ pkgs.vimPlugins.neorg ];
            oil = [ pkgs.vimPlugins.oil-nvim ];
          };
        };

      packageDefinitions = {
        nvim =
          { pkgs, name, ... }:
          let
            python3 = mkPython pkgs;
          in
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
            extra = {
              python3 = "${python3}";
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
            pkgs.nixfmt-rfc-style
            pkgs.stylua
            pkgs.treefmt
          ];
          text = "exec treefmt \"$@\"";
        };
      }
    );
}
