{
  config,
  pkgs,
  ...
}:
let
in
{
  imports = [
    ./tofi.nix
    ./waybar.nix
    ./hyprland.nix
  ];

  # Hyprland
  wayland.windowManager.hyprland.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nwg-displays
  ];

  # Fonts
  fonts.fontconfig.enable = true;

  xdg.configFile."hypr/hyprpaper_background.jpg".source = ./background.jpg;
  services.hyprpaper =
    let
      background-path = "${config.xdg.configHome}/hypr/hyprpaper_background.jpg";
    in
    {
      enable = true;
      settings = {
        splash = false;
        preload = [ background-path ];
        wallpaper = ",${background-path}";
      };
    };

  services = {
    network-manager-applet.enable = true;
    swaync.enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };
  };

  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 38;
    gtk.enable = true;
    x11.enable = true;
  };
}
