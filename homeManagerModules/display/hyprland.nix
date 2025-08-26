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

  hyprlandUpdateDisplayd =
    let
      socat = "${pkgs.socat}/bin/socat";
      hyprctl = "${pkgs.hyprland}/bin/hyprctl";
      jq = "${pkgs.jq}/bin/jq";

      generateSessionScript =
        name: session:
        let
          monitorNames = map (m: builtins.elemAt (builtins.split "," m) 0) session.monitors;
          monitorsString = builtins.concatStringsSep "," (map (m: "\"${m}\"") monitorNames);
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
          # session: ${name}
          target_monitors=($(echo '[${monitorsString}]' | ${jq} -r 'sort.[]'))
          if [ $monitors == $target_monitors ]; then
            ${hyprctl} --batch "${
              builtins.concatStringsSep " ; " (setMonitorCommands ++ setWorkspaceCommands)
            }"
          fi
        '';
    in
    pkgs.writeShellScriptBin "hyprland-update-displayd" ''
      function handle() {
        if [[ ''${1:0:12} == "monitoradded" ]] || [[ ''${1:0:14} == "monitorremoved" ]]; then

          monitors=($(${hyprctl} monitors all -j | ${jq} '[ .[].name ] | sort.[]'))

          ${strings.concatLines (attrsets.mapAttrsToList generateSessionScript cfg.sessions)}
        fi
      }

      ${socat} - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do handle $line; done
    '';

in
{
  imports = [ ./hyprland-keybinds.nix ];

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

    wayland.windowManager.hyprland = {
      systemd.enable = true;

      settings = {

        # default display settings
        monitor = cfg.sessions.default.monitors;

        exec-once = [
          "${hyprlandUpdateDisplayd}/bin/hyprland-update-displayd"
        ];
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

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

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

        workspace = [
          "w[tv1], gapsout:0, gapsin:0"
          "f[1], gapsout:0, gapsin:0"
        ];
        windowrulev2 = [
          "bordersize 0, floating:0, onworkspace:w[tv1]"
          "rounding 0, floating:0, onworkspace:w[tv1]"
          "bordersize 0, floating:0, onworkspace:f[1]"
          "rounding 0, floating:0, onworkspace:f[1]"
        ];
      };
    };
  };
}
