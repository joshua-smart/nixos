{ ... }: {
  imports = [ ../../homeManagerModules ];
  display.wallpaper.monitors = [ "eDP-1" ];

  display.hyprland = {
    workspaces = { eDP-1 = [ 1 2 3 4 5 ]; };
    keybinds.volume-step = 5;
  };

  display.bar = {
    monitors = [ "eDP-1" ];
    workspaces = [ 1 2 3 4 5 ];
  };
}
