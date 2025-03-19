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

  services = {
    udiskie.enable = true;
    # Bluetooth media control
    mpris-proxy.enable = true;
    syncthing.enable = true;
  };

  programs = {
    password-store.enable = true;
    godot.enable = true;
  };

  home.packages = with pkgs; [
    inkscape
    gimp
    maptool
    gramps
  ];

  wayland.windowManager.hyprland = {
    keybinds.volume-step = 5;
    sessions = {
      default = {
        monitors = [ "eDP-1,prefered,auto,1" ];
        workspaces = {
          eDP-1 = builtins.genList (x: x + 1) 5;
        };
      };
      external-HDMI-1 = {
        monitors = [
          "eDP-1,prefered,auto,1"
          "HDMI-A-1,1920x1080,auto-left,1"
        ];
        workspaces = {
          eDP-1 = [ 2 ];
          HDMI-A-1 = [ 1 ];
        };
      };
      external-DP-2 = {
        monitors = [
          "eDP-1,prefered,auto,1"
          "DP-2,3840x1600@60.00Hz,auto-left,1"
        ];
        workspaces = {
          eDP-1 = [ 2 ];
          DP-2 = [ 1 ];
        };
      };
    };
  };

  programs.waybar = {
    monitors = [ "eDP-1" ];
    workspaces = [
      1
      2
    ];
    modules = "disk,cpu,memory,backlight,battery,pulseaudio,network,tray";
  };
}
