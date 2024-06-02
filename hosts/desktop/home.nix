{ pkgs, ... }: {
  imports = [ ../../homeManagerModules ];
  display.wallpaper.monitors = [ "HDMI-A-1" "HDMI-A-2" ];

  display.hyprland = {
    workspaces = {
      HDMI-A-1 = [ 1 ];
      HDMI-A-2 = [ 2 ];
    };
    nvidia = true;
    keybinds.volume-step = 1;
  };

  display.bar = {
    monitors = [ "HDMI-A-2" ];
    workspaces = [ 1 2 ];
    network-type = "wired";
  };

  home.packages = with pkgs; [ ryujinx ];
}
