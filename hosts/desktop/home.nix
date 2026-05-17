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
    nvidia = true;
    keybinds.volume-step = 1;
  };

  programs.waybar = {
    monitors = [ "HDMI-A-1" ];
    workspaces = [
      1
      2
    ];
    modules = "disk,cpu,memory,pulseaudio,network,tray";
  };

  home.packages = with pkgs; [
    ryubing
    gimp
    inkscape
    antimicrox
    # maptool
    qbittorrent
    prismlauncher
    freecad
    povray
    myPackages.magicq
    myPackages.cue-view
    myPackages.ksa
  ];
}
