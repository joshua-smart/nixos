{ lib, config, ... }:
with lib; {

  options.display.wallpaper = {
    monitors = mkOption { type = types.listOf types.str; };
  };

  config = {
    home.file.".config/hypr/hyprpaper.conf".text = let
      wallpaper-entries = builtins.concatStringsSep "\n"
        (builtins.map (m: "wallpaper = ${m},~/.config/hypr/background.jpg")
          config.display.wallpaper.monitors);
    in ''
      preload = ~/.config/hypr/background.jpg
      ${wallpaper-entries}
    '';

    home.file.".config/hypr/background.jpg".source = ./background.jpg;
  };
}
