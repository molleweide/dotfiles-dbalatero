{ config, lib, pkgs, rustPlatform, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "molleweide";
  home.homeDirectory = "/Users/hjalmarjakobsson";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  home.packages = [
    pkgs.tree-sitter
    pkgs.neovim-nightly
    pkgs.gitAndTools.gitstatus
    (import ./ddcctl.nix { pkgs = pkgs; })
    (import ./proximity-sort.nix { lib = lib; pkgs = pkgs; })
    pkgs.cargo
    pkgs.rustc
  ];
}
