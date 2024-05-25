{ lib, config, ... }:
with lib; {
  imports = [ ./waybar.nix ./hyprland.nix ./hyprpaper ./cursor.nix ./gtk.nix ];

  options.display.workspaces = mkOption {
    type = types.attrsOf (types.listOf types.int);
    description = ''
      Mapping from monitors to workspaces
    '';
    example = literalExpression "{ eDP-1 = [ 0 1 2 3 4 ]; }";
  };

  config = {
    display.hyprland.workspaces = config.display.workspaces;
    display.waybar.workspaces = config.display.workspaces;
  };
}
