{ config, lib, ... }:
let
  inherit (lib)
    mkOption
    types
    mkIf
    optionals
    ;
  cfg = config.wayland.windowManager.hyprland;
in
{
  imports = [ ./keybinds.nix ];

  options.wayland.windowManager.hyprland = {
    monitors = mkOption { type = types.listOf types.str; };
    workspaces = mkOption { type = types.attrsOf (types.listOf types.int); };
    nvidia = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Add nvidia hardware support
      '';
    };
  };

  config = mkIf cfg.enable {

    wayland.windowManager.hyprland = {
      systemd.enable = true;

      settings = {
        monitor = cfg.monitors;

        exec-once = [ ];
        env = optionals cfg.nvidia [ "WLR_NO_HARDWARE_CURSORS,1" ];

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;

          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          resize_on_border = false;
          allow_tearing = false;
          layout = "master";
        };

        cursor.inactive_timeout = 1;

        decoration = {
          rounding = 10;

          active_opacity = 1.0;
          inactive_opacity = 1.0;

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";

          blur = {
            enabled = true;
            size = 8;
            passes = 1;

            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
          animation = [
            "windows, 1, 5, default"
            "windowsOut, 1, 5, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 5, default"
            "fade, 1, 5, default"
            "workspaces, 1, 5, default"
          ];
        };

        master = {
          new_status = "master";
          no_gaps_when_only = 1;
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
          new_window_takes_over_fullscreen = 1;
        };

        # INPUT
        input = {
          kb_layout = "gb";
          follow_mouse = 1;
          sensitivity = 0;

          touchpad.natural_scroll = false;
        };

        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
        };

        # WORKSPACES
        workspace =
          let
            toLine = (
              monitor: workspace:
              let
                ws = toString workspace;
              in
              "${ws},monitor:${monitor}"
            );
            lists = builtins.attrValues (
              builtins.mapAttrs (monitor: workspaces: map (ws: toLine monitor ws) workspaces) cfg.workspaces
            );
          in
          builtins.concatLists lists;

        # LAYER RULES
        layerrule = [
          "blur,waybar"
          "blur,launcher"
        ];
      };
    };
  };
}
