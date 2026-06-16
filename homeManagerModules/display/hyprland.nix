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
    ;

  cfg = config.wayland.windowManager.hyprland;
in
{
  imports = [ ./hyprland-keybinds.nix ];

  options.wayland.windowManager.hyprland = {
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
      configType = "hyprlang";
      systemd.enable = true;

      settings = {

        source = [
          "~/.config/hypr/monitors.conf"
          "~/.config/hypr/workspaces.conf"
        ];

        env = optionals cfg.nvidia [ "WLR_NO_HARDWARE_CURSORS,1" ];

        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 0;
          resize_on_border = false;
          allow_tearing = false;
          layout = "master";
        };

        cursor.inactive_timeout = 1;

        decoration = {
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

          blur = {
            enabled = true;
            size = 16;
            passes = 2;

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
          mfact = 0.6;
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
          on_focus_under_fullscreen = 1;
        };

        # INPUT
        input = {
          kb_layout = "gb";
          follow_mouse = 1;
          sensitivity = 0;

          touchpad.natural_scroll = false;
        };

        # LAYER RULES
        layerrule = [
          {
            name = "waybar-blur";
            match.namespace = "waybar";
            blur = true;
          }
          {
            name = "launcher-blur";
            match.namespace = "launcher";
            blur = true;
          }
        ];
      };
    };
  };
}
