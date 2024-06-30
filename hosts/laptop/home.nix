{ pkgs, ... }:
{
  imports = [ ../../homeManagerModules ];
  display.wallpaper.monitors = [
    "eDP-1"
    "HDMI-A-1"
  ];

  display.hyprland = {
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

  display.bar = {
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
