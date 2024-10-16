{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkOption
    types
    mkIf
    optionals
    strings
    attrsets
    ;

  cfg = config.wayland.windowManager.hyprland;

  sessionOptions = {
    options = {
      monitors = mkOption { type = types.listOf types.str; };
      workspaces = mkOption { type = types.attrsOf (types.listOf types.int); };
    };
  };

  updateDisplay = pkgs.writeShellScriptBin "hyprland-update-display" (
    ''
      match_session () {
        hyprctl monitors all -j | ${pkgs.jq}/bin/jq -e '([ .[] | .name ] | sort) == ([ '"$1"' ] | sort)' > /dev/null
      }
    ''
    + strings.concatLines (
      attrsets.mapAttrsToList (
        name: session:
        let
          formatList = l: builtins.concatStringsSep "," (map (ws: "\"${ws}\"") l);
          monitorNames = map (m: builtins.head (builtins.split "," m)) session.monitors;

          setMonitorCommands = map (m: ''keyword monitor ${m}'') session.monitors;

          setWorkspaceCommands = builtins.concatLists (
            attrsets.mapAttrsToList (
              monitor: workspaces:
              map (ws: ''dispatch moveworkspacetomonitor ${toString ws} ${monitor}'') workspaces
            ) session.workspaces
          );

        in
        # bash
        ''
          if match_session '${formatList monitorNames}'; then
            hyprctl --batch "${builtins.concatStringsSep " ; " setMonitorCommands}"
            hyprctl --batch "${builtins.concatStringsSep " ; " setWorkspaceCommands}"
          fi
        ''
      ) cfg.sessions
    )
  );
in
{
  imports = [ ./keybinds.nix ];

  options.wayland.windowManager.hyprland = {
    sessions = mkOption { type = types.attrsOf (types.submodule sessionOptions); };
    nvidia = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Add nvidia hardware support
      '';
    };
  };

  config = mkIf cfg.enable {

    home.packages = [ updateDisplay ];

    wayland.windowManager.hyprland = {
      systemd.enable = true;

      settings = {

        # default display settings
        monitor = cfg.sessions.default.monitors;

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

        # LAYER RULES
        layerrule = [
          "blur,waybar"
          "blur,launcher"
        ];
      };
    };
  };
}
