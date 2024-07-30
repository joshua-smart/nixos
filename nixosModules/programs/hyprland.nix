{ config, lib, ... }: with lib; {
  config = mkIf config.programs.hyprland.enable {
    programs.hyprland.xwayland.enable = true;
  };
}