{
  description = "A great neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nightvim.url = "github:cfcosta/nightvim.nix";

    cmp-buffer.url = "github:hrsh7th/cmp-buffer";
    cmp-cmdline.url = "github:hrsh7th/cmp-cmdline";
    cmp-nvim-lsp.url = "github:hrsh7th/cmp-nvim-lsp";
    cmp-path.url = "github:hrsh7th/cmp-path";
    cmp-snippy.url = "github:dcampos/cmp-snippy";
    codegpt.url = "github:dpayne/codegpt.nvim";
    comment.url = "github:numtostr/comment.nvim";
    diffview.url = "github:sindrets/diffview.nvim";
    gitsigns.url = "github:lewis6991/gitsigns.nvim";
    mason-lspconfig.url = "github:williamboman/mason-lspconfig.nvim";
    mason.url = "github:williamboman/mason.nvim";
    neo-tree.url = "github:nvim-neo-tree/neo-tree.nvim";
    neogit.url = "github:TimUntersberger/neogit";
    neorg.url = "github:nvim-neorg/neorg";
    nui.url = "github:muniftanjim/nui.nvim";
    null-ls.url = "github:jose-elias-alvarez/null-ls.nvim";
    nvim-autopairs.url = "github:windwp/nvim-autopairs";
    nvim-cmp.url = "github:hrsh7th/nvim-cmp";
    nvim-dap.url = "github:mfussenegger/nvim-dap";
    nvim-lspconfig.url = "github:neovim/nvim-lspconfig";
    nvim-snippy.url = "github:dcampos/nvim-snippy";
    nvim-surround.url = "github:kylechui/nvim-surround";
    nvim-treesitter-endwise.url = "github:RRethy/nvim-treesitter-endwise";
    nvim-treesitter.url = "github:nvim-treesitter/nvim-treesitter";
    plenary.url = "github:nvim-lua/plenary.nvim";
    rust-tools.url = "github:simrat39/rust-tools.nvim";
    telescope.url = "github:nvim-telescope/telescope.nvim";
    toggleterm.url = "github:akinsho/toggleterm.nvim";
    tokyonight.url = "github:folke/tokyonight.nvim";
    trouble.url = "github:folke/trouble.nvim";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, home-manager, nightvim, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      home = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          nightvim.hmModule
          ({ options, config, lib, pkgs }: {
            programs.nightvim = {
              enable = true;

              options = {
                tabstop = 2;
                softtabstop = 2;
                shiftwidth = 2;
                expandtab = true;
                number = true;
                relativenumber = true;
              };

              globals.mapleader = " ";

              keybindings = {
                n."<leader>wv" = "<cmd>vsplit<cr>";
                n."<leader>ws" = "<cmd>split<cr>";
                n."<leader>wc" = "<cmd>close<cr>";
                n."<leader>wo" = "<cmd>only<cr>";
              };

              plugins = with inputs; [
                ({
                  source = tokyonight;
                  lazy = false;
                  config = ''
                    vim.cmd [[colorscheme tokyonight]]
                  '';
                })
                ({
                  source = codegpt;
                  dependencies = [ nui plenary ];
                  commands = [ "Chat" ];
                  config = ''
                    if os.getenv "OPENAI_API_KEY" then
                      require "codegpt.config"
                    end
                  '';
                })
                ({ source = comment; })
                ({ source = gitsigns; })
                ({
                  source = mason;
                  dependencies = [
                    nvim-dap
                    nvim-lspconfig
                    plenary
                    rust-tools
                    mason-lspconfig
                    nvim-lspconfig
                    cmp-nvim-lsp
                    cmp-buffer
                    cmp-path
                    cmp-cmdline
                    nvim-cmp
                    nvim-snippy
                    cmp-snippy
                    neorg
                  ];

                  config = ''
                    local lspconfig = require "lspconfig"
                    local lsp_defaults = lspconfig.util.default_config

                    lsp_defaults.capabilities =
                      vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

                    require("mason").setup {
                      -- Adds the path from mason into the end of the PATH env variable.
                      -- Since we are using Nix to install it, we can assume that it is
                      -- going to come from somewhere else.
                      PATH = "append",
                    }
                    require("mason-lspconfig").setup()
                    require("mason-lspconfig").setup_handlers {
                      function(server_name) -- default handler (optional)
                        lspconfig[server_name].setup {}
                      end,
                      ["rust_analyzer"] = function()
                        require("rust-tools").setup {
                          capabilities = lsp_defaults.capabilities,
                        }
                      end,
                    }

                    local cmp = require "cmp"

                    cmp.setup {
                      snippet = {
                        expand = function(args)
                          require("snippy").expand_snippet(args.body)
                        end,
                      },
                      window = {
                        completion = cmp.config.window.bordered(),
                        documentation = cmp.config.window.bordered(),
                      },
                      mapping = cmp.mapping.preset.insert {
                        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                        ["<C-f>"] = cmp.mapping.scroll_docs(4),
                        ["<C-Space>"] = cmp.mapping.complete(),
                        ["<C-e>"] = cmp.mapping.abort(),
                        ["<CR>"] = cmp.mapping.confirm { select = true },
                      },
                      sources = cmp.config.sources({
                        { name = "nvim_lsp" },
                        { name = "snippy" },
                        { name = "neorg" },
                      }, {
                        { name = "buffer" },
                      }),
                    }
                  '';
                })
              ];
            };
          })
        ];
      };
    };
}
