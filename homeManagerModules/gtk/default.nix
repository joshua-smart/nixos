{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
{

  config = mkIf config.gtk.enable {
    gtk = {
      theme = {
        name = "gruvbox-dark";
        package = pkgs.gruvbox-dark-gtk;
      };
      iconTheme = {
        name = "Monday";
        package = pkgs.callPackage ./monday-icon-theme.nix { };
      };
    };
  };
}
