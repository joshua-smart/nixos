{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.hyprland.enable { programs.hyprland.xwayland.enable = true; };
}
