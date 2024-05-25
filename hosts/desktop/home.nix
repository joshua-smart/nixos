{ ... }: {
  imports = [ ../../homeManagerModules ];
  display.wallpaper.monitors = [ "HDMI-A-1" "HDMI-A-2" ];

  display.workspaces = {
    HDMI-A-1 = [ 1 ];
    HDMI-A-2 = [ 2 ];
  };
}
