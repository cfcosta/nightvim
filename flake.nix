{
  description = "A Nix-native way of managing Neovim configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager }:
    {
      lib.mkPlugin = name: dir: spec:
        rec {
          inherit name dir;
          depends = [ ];
          inputs = [ ];
          config = ''require("${module}").setup {}'';
          module = name;
        } // spec;
      hmModule = { options, config, lib, pkgs, ... }:
        let cfg = config.programs.nightvim;
        in {
          options.programs.nightvim = with lib; {
            enable = mkEnableOption "NightVim";

            plugins = mkOption {
              type = types.listOf (types.submodule {
                options = {
                  name = mkOption { type = types.str; };
                  dir = mkOption { type = types.path; };
                  depends = mkOption { type = types.listOf types.str; };
                  inputs = mkOption { type = types.listOf types.path; };
                  config = mkOption { type = types.str; };
                  module = mkOption { type = types.str; };
                };
              });
              default = [ ];
            };

            extraConfig = mkOption {
              type = types.str;
              default = "";
            };
          };

          config = let
            pluginNames = builtins.map (p: p.name) cfg.plugins;
            pluginFolders = lib.foldl' (acc: attr:
              acc // {
                "nvim/night/plugins/start/${attr.name}".source = attr.dir;
              }) { } cfg.plugins;
            mapSpec = p: ''
              NightVim.setup_plugin(
                "${p.name}",
                { ${
                  builtins.concatStringsSep " , "
                  (builtins.map (d: ''"${d}"'') p.depends)
                } },
                function()
                  ${builtins.concatStringsSep "\n" p.config}
                end
              )'';
          in (lib.mkIf cfg.enable {
            programs.neovim.enable = true;

            xdg.configFile = pluginFolders // {
              "nvim/init.lua".text = ''
                ${builtins.readFile ./module.lua}

                ${builtins.concatStringsSep "\n"
                (builtins.map mapSpec cfg.plugins)}

                ${cfg.extraConfig}

                NightVim.finish()'';
            };
          });
        };
    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            lua-language-server
            stylua
            nixfmt
            rnix-lsp
          ];
        };
      });
}
