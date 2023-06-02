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

          options = {
            tabstop = mkOption {
              type = lib.types.int;
              description = ''
                Number of spaces that a <Tab> in the file counts for.  Also see
                the |:retab| command, and the 'softtabstop' option.
              '';
              default = 8;
            };

            softtabstop = mkOption {
              type = lib.types.int;
              description = ''
                Number of spaces that a <Tab> counts for while performing editing
                operations, like inserting a <Tab> or using <BS>.  It "feels" like
                <Tab>s are being inserted, while in fact a mix of spaces and <Tab>s is
                used.  This is useful to keep the 'ts' setting at its standard value
                of 8, while being able to edit like it is set to 'sts'.
              '';
              default = 0;
            };

            shiftwidth = mkOption {
              type = lib.types.int;
              description = ''
                Number of spaces to use for each step of (auto)indent.  Used for
                |'cindent'|, |>>|, |<<|, etc.
              '';
              default = 8;
            };

            expandtab = mkEnableOption ''
              In Insert mode: Use the appropriate number of spaces to insert a
              <Tab>. Spaces are used in indents with the '>' and '<' commands and
              when 'autoindent' is on.
            '';

            number = mkEnableOption ''
              Print the line number in front of each line.  When the 'n' option is
              excluded from 'cpoptions' a wrapped line will not use the column of
              line numbers.
            '';

            relativenumber = mkEnableOption ''
              Show the line number relative to the line with the cursor in front of
              each line. Relative line numbers help you use the |count| you can
              precede some vertical motion commands (e.g. j k + -) with, without
              having to calculate it yourself.
            '';
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

        config = lib.mkIf cfg.enable {
          programs.neovim.enable = true;
          # TODO: Implement things :D
        };
      };
  };
}
