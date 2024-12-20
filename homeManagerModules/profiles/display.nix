{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.display.enable = mkEnableOption "display profile";

  config = mkIf config.profiles.display.enable {
    wayland.windowManager.hyprland.enable = true;

    # Fonts
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];

    programs = {
      tofi.enable = true;
      waybar.enable = true;
    };

    services = {
      network-manager-applet.enable = true;
      swaync.enable = true;
      hyprpaper.enable = true;
    };


    gtk.enable = true;

    home.pointerCursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 38;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
