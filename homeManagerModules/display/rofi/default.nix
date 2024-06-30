{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    location = "top";
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = ./theme.rasi;
  };
}
