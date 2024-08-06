{ lib, config, ... }:
with lib;
let
  cfg = config.services.hyprpaper;
in
{

  options.services.hyprpaper = {
    monitors = mkOption { type = types.listOf types.str; };
  };

  config = mkIf config.services.hyprpaper.enable {
    xdg.configFile."hypr/hyprpaper_background.jpg".source = ./background.jpg;

    services.hyprpaper =
      let
        background-path = "${config.xdg.configHome}/hypr/hyprpaper_background.jpg";
      in
      {
        settings = {
          splash = false;

          preload = [ background-path ];
          wallpaper = map (m: "${m},${background-path}") cfg.monitors;
        };
      };
  };
}
