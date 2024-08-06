{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.profiles.display.enable = mkEnableOption "display profile";

  config = mkIf config.profiles.display.enable {
    wayland.windowManager.hyprland.enable = true;

    # Fonts
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];

    programs = {
      rofi.enable = true;
      waybar.enable = true;
    };

    services = {
      network-manager-applet.enable = true;
      swaync.enable = true;
      hyprpaper.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    };

    gtk.enable = true;

    home.pointerCursor = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 38;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
