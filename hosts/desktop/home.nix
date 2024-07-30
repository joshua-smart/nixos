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

  display.wallpaper.monitors = [
    "HDMI-A-1"
    "HDMI-A-2"
  ];

  display.hyprland = {
    monitors = [
      "HDMI-A-1,prefered,auto,1"
      "HDMI-A-2,prefered,auto-right,1"
    ];
    workspaces = {
      HDMI-A-1 = [ 1 ];
      HDMI-A-2 = [ 2 ];
    };
    nvidia = true;
    keybinds.volume-step = 1;
  };

  display.bar = {
    monitors = [ "HDMI-A-2" ];
    workspaces = [
      1
      2
    ];
    modules = [
      "disk"
      "cpu"
      "memory"
      "pulseaudio"
      "network"
      "tray"
    ];
  };

  home.packages = with pkgs; [ ryujinx ];
}
