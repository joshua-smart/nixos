{ lib, config, ... }:
with lib;
let
  background-path = "~/.config/hypr/background.jpg";
  cfg = config.display.wallpaper;
in
{

  options.services.hyprpaper = {
    monitors = mkOption { type = types.listOf types.str; };
  };

  config = mkIf config.services.hyprpaper.enable {
    xdg.configFile."hypr/background.jpg".source = ./background.jpg;

    services.hyprpaper = {
      settings = {
        splash = false;

        preload = [ background-path ];
        wallpaper = map (m: "${m},${background-path}") cfg.monitors;
      };
    };
  };
}
