{ pkgs, pkgs-unstable, ... }:

{
  imports = [ ../../homeManagerModules ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "js";
  home.homeDirectory = "/home/js";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [ discord tree prismlauncher ])
    ++ (with pkgs-unstable; [ nh ]);

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = { EDITOR = "hx"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}