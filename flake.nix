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

  outputs = {
    hmModule = { options, config, lib, pkgs, ... }:
      let cfg = config.programs.nightvim;
      in {
        options.programs.nightvim = with lib; {
          enable = mkEnableOption "NightVim";

          options = {
            tabstop = mkOption {
              type = lib.types.int;
              default = 4;
            };

            softtabstop = mkOption {
              type = lib.types.int;
              default = 4;
            };

            shiftwidth = mkOption {
              type = lib.types.int;
              default = 4;
            };

            expandtab = mkEnableOption "expandtab";
            number = mkEnableOption "number";
            relativenumber = mkEnableOption "relativenumber";
          };

          globals = {
            mapleader = mkOption {
              type = lib.types.string;
              default = " ";
            };
          };

          keybindings = {
            n = mkOption {
              type = lib.types.any;
              default = { };
            };
          };
        };

        config = with nightvim;
          lib.mkIf cfg.enable {
            programs.neovim.enable = true;
            # TODO: Implement things :D
          };
      };
  };
}
