{ ... }: {
  imports = [ ../../homeManagerModules ];
  display.wallpaper.monitors = [ "eDP-1" ];

  display.workspaces = { eDP-1 = [ 1 2 3 4 5 ]; };

  display.bar = {
    monitors = [ "eDP-1" ];
    workspaces = [ 1 2 3 4 5 ];
  };
}
