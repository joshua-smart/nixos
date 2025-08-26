{ config, pkgs, ... }:
{
  imports = [ ../../homeManagerModules ];

  programs = {
    password-store.enable = true;
  };

  services = {
    udiskie.enable = true;
    syncthing.enable = true;
    easyeffects = {
      enable = true;
      preset = "denoise";
    };
    trayscale.enable = true;
  };

  wayland.windowManager.hyprland = {
    sessions.default = {
      monitors = [
        "HDMI-A-1,prefered,auto,1"
        "HDMI-A-2,prefered,auto-right,1"
      ];
      workspaces = {
        HDMI-A-1 = [ 1 ];
        HDMI-A-2 = [ 2 ];
      };
    };
    nvidia = true;
    keybinds.volume-step = 1;
  };

  programs.waybar = {
    monitors = [ "HDMI-A-2" ];
    workspaces = [
      1
      2
    ];
    modules = "disk,cpu,memory,pulseaudio,network,tray";
  };

  home.packages = with pkgs; [
    ryujinx
    gimp
    inkscape
    antimicrox
    maptool
    qbittorrent
    prismlauncher
  ];
}
