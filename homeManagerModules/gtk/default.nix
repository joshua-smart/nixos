{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
in
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
