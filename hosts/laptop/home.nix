{ pkgs, ... }:
{
  imports = [ ../../homeManagerModules ];

  profiles = {
    display.enable = true;
    shell.enable = true;
    desktop-apps.enable = true;
    games.enable = true;
    accounts.enable = true;
  };

  scripts.enable = true;

  programs = {
    password-store.enable = true;
  };

  services = {
    udiskie.enable = true;
  };

  services.hyprpaper.monitors = [
    "eDP-1"
    "HDMI-A-1"
  ];

  wayland.windowManager.hyprland = {
    monitors = [
      "eDP-1,prefered,auto,1"
      "HDMI-A-1,1920x1080@60.00Hz,auto-left,1"
    ];
    workspaces = {
      eDP-1 = [ 2 ];
      HDMI-A-1 = [ 1 ];
    };
    keybinds.volume-step = 5;
  };

  programs.waybar = {
    monitors = [ "eDP-1" ];
    workspaces = [
      1
      2
    ];
    modules = [
      "disk"
      "cpu"
      "memory"
      "backlight"
      "battery"
      "pulseaudio"
      "network"
      "tray"
    ];
  };

  # Bluetooth media control
  services.mpris-proxy.enable = true;
}
