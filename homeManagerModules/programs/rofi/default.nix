{ pkgs, config, lib, ... }: with lib;
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
