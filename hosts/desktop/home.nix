{ ... }: {
  imports = [ ../../homeManagerModules ];
  display.wallpaper.monitors = [ "HDMI-A-1" "HDMI-A-2" ];

  display.hyprland = {
    workspaces = {
      HDMI-A-1 = [ 1 ];
      HDMI-A-2 = [ 2 ];
    };
    nvidia = true;
  };

  display.bar = {
    monitors = [ "HDMI-A-2" ];
    workspaces = [ 1 2 ];
  };
}
