{
  description = "A great neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nightvim = {
      url = "github:cfcosta/nightvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    cmp-cmdline = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    cmp-snippy = {
      url = "github:dcampos/cmp-snippy";
      flake = false;
    };
    codegpt = {
      url = "github:dpayne/codegpt.nvim";
      flake = false;
    };
    comment = {
      url = "github:numtostr/comment.nvim";
      flake = false;
    };
    diffview = {
      url = "github:sindrets/diffview.nvim";
      flake = false;
    };
    gitsigns = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    neo-tree = {
      url = "github:nvim-neo-tree/neo-tree.nvim";
      flake = false;
    };
    neogit = {
      url = "github:TimUntersberger/neogit";
      flake = false;
    };
    neorg = {
      url = "github:nvim-neorg/neorg";
      flake = false;
    };
    nui = {
      url = "github:muniftanjim/nui.nvim";
      flake = false;
    };
    null-ls = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };
    nvim-autopairs = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };
    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    nvim-dap = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };
    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    nvim-snippy = {
      url = "github:dcampos/nvim-snippy";
      flake = false;
    };
    nvim-surround = {
      url = "github:kylechui/nvim-surround";
      flake = false;
    };
    nvim-treesitter-endwise = {
      url = "github:RRethy/nvim-treesitter-endwise";
      flake = false;
    };
    nvim-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    rust-tools = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };
    telescope = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    toggleterm = {
      url = "github:akinsho/toggleterm.nvim";
      flake = false;
    };
    tokyonight = {
      url = "github:folke/tokyonight.nvim";
      flake = false;
    };
    trouble = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, home-manager, nightvim, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      vimConfig = { options, config, lib, pkgs, ... }: {
        imports = [ nightvim.hmModule ];

        programs.nightvim = {
          enable = true;
          plugins = with inputs; [
            (nightvim.lib.mkPlugin "cmp-buffer" cmp-buffer)
            (nightvim.lib.mkPlugin "cmp-cmdline" cmp-cmdline)
            (nightvim.lib.mkPlugin "cmp-nvim-lsp" cmp-nvim-lsp)
            (nightvim.lib.mkPlugin "cmp-path" cmp-path)
            (nightvim.lib.mkPlugin "cmp-snippy" cmp-snippy)
            (nightvim.lib.mkPlugin "codegpt" codegpt)
            (nightvim.lib.mkPlugin "comment" comment)
            (nightvim.lib.mkPlugin "diffview" diffview)
            (nightvim.lib.mkPlugin "gitsigns" gitsigns)
            (nightvim.lib.mkPlugin "neo-tree" neo-tree)
            (nightvim.lib.mkPlugin "neogit" neogit)
            (nightvim.lib.mkPlugin "neorg" neorg)
            (nightvim.lib.mkPlugin "nui" nui)
            (nightvim.lib.mkPlugin "null-ls" null-ls)
            (nightvim.lib.mkPlugin "nvim-autopairs" nvim-autopairs)
            (nightvim.lib.mkPlugin "nvim-cmp" nvim-cmp)
            (nightvim.lib.mkPlugin "nvim-dap" nvim-dap)
            (nightvim.lib.mkPlugin "nvim-lspconfig" nvim-lspconfig)
            (nightvim.lib.mkPlugin "nvim-snippy" nvim-snippy)
            (nightvim.lib.mkPlugin "nvim-surround" nvim-surround)
            (nightvim.lib.mkPlugin "nvim-treesitter-endwise"
              nvim-treesitter-endwise)
            (nightvim.lib.mkPlugin "nvim-treesitter" nvim-treesitter)
            (nightvim.lib.mkPlugin "plenary" plenary)
            (nightvim.lib.mkPlugin "rust-tools" rust-tools)
          ];
        };

        home.username = "nightvim";
        home.homeDirectory =
          if pkgs.stdenv.isLinux then "/home/nightvim" else "/Users/nightvim";

        home.stateVersion = "23.05";
      };
    in
    {
      result = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ vimConfig ];
      };
    };
}
