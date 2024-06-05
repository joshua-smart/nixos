{ lib, config, ... }:
with lib;
let
  background-path = "~/.config/hypr/background.jpg";
  cfg = config.display.wallpaper;
in {

  options.display.wallpaper = {
    monitors = mkOption { type = types.listOf types.str; };
  };

  config = {

    xdg.configFile."hypr/background.jpg".source = ./background.jpg;

    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;

        preload = [ background-path ];
        wallpaper = map (m: "${m},${background-path}") cfg.monitors;
      };
    };
  };
}
