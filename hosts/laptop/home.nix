{ pkgs, ... }:
{
  imports = [ ../../homeManagerModules ];

  services = {
    udiskie.enable = true;
    # Bluetooth media control
    mpris-proxy.enable = true;
    syncthing.enable = true;
    blueman-applet.enable = true;
    trayscale.enable = true;
  };

  programs = {
    password-store.enable = true;
    # godot.enable = true;
  };

  home.packages = with pkgs; [
    inkscape
    gimp
    # gramps
    prismlauncher
    myPackages.magicq
    freecad
  ];

  wayland.windowManager.hyprland = {
    settings = {
      # monitor = [
      #   "eDP-1,prefered,0x0,1"
      #   ",prefered,auto-left,1"
      # ];
      # workspace = [
      #   "1,monitor:DP-2"
      #   "2,monitor:eDP-1"
      # ];
    };
    keybinds.volume-step = 5;
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
