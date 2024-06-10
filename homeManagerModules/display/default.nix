{ pkgs, ... }: {
  imports =
    [ ./waybar ./rofi ./hyprland.nix ./hyprpaper ./cursor.nix ./gtk.nix ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
  };
}
