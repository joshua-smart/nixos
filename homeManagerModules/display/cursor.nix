{ pkgs, ... }:
{
  home.pointerCursor = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 38;
    gtk.enable = true;
    x11.enable = true;
  };
}
