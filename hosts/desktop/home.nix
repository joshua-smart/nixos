{ ... }: {
  imports = [ ../../homeManagerModules ];
  display.wallpaper.monitors = [ "HDMI-A-1" "HDMI-A-2" ];

  display.workspaces = {
    HDMI-A-1 = [ 1 ];
    HDMI-A-2 = [ 2 ];
  };

  display.bar = {
    monitors = [ "HDMI-A-2" ];
    workspaces = [ 1 2 ];
  };
}
