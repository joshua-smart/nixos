{ ... }: {
  imports = [ ../../homeManagerModules ];
  display.wallpaper.monitors = [ "eDP-1" ];

  display.hyprland = {
    monitors = [ "eDP-1,prefered,auto,1" ];
    workspaces = { eDP-1 = [ 1 2 3 4 5 ]; };
    keybinds.volume-step = 5;
  };

  display.bar = {
    monitors = [ "eDP-1" ];
    workspaces = [ 1 2 3 4 5 ];
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
