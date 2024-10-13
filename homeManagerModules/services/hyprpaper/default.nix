{ lib, config, ... }:
let
  inherit (lib) mkIf;
in
{
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
          wallpaper = ",${background-path}";
        };
      };
  };
}
