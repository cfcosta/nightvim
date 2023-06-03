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

  outputs = { self, nixpkgs, flake-utils, home-manager }: {
    hmModule = { options, config, lib, pkgs, ... }:
      let cfg = config.programs.nightvim;
      in {
        options.programs.nightvim = with lib; {
          enable = mkEnableOption "NightVim";
          plugins = mkOption { type = types.listOf types.any; };
        };

        config = lib.mkIf cfg.enable {
          programs.neovim.enable = true;

          xdg.configFile."nightvim/init.lua" = {
            source = ''
              print("TODO: Implement me")
            '';
          };
        };
      };
  };
}
