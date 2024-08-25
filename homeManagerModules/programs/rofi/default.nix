{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.rofi.enable {
    programs.rofi = {
      package = pkgs.rofi-wayland;

      location = "top";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      theme = ./theme.rasi;
    };
  };
}
