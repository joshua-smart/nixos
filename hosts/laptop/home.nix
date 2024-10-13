{ ... }:
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
    godot.enable = true;
  };

  services = {
    udiskie.enable = true;
    # Bluetooth media control
    mpris-proxy.enable = true;
  };
  ];

  wayland.windowManager.hyprland.keybinds.volume-step = 5;

  programs.waybar = {
    monitors = [ "eDP-1" ];
    workspaces = [
      1
      2
    ];
    modules = "disk,cpu,memory,backlight,battery,pulseaudio,network,tray";
  };
}
