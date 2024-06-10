{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.display.hyprland;
  terminal = "${pkgs.alacritty}/bin/alacritty";
  browser = "${pkgs.firefox}/bin/firefox";
  menu = "${pkgs.rofi-wayland}/bin/rofi -show drun";
in {

  options.display.hyprland = {
    monitors = mkOption { type = types.listOf types.str; };
    workspaces = mkOption { type = types.attrsOf (types.listOf types.int); };
    nvidia = mkOption {
      type = types.bool;
      default = false;
    };
    keybinds = { volume-step = mkOption { type = types.int; }; };
  };

  config = {

    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
      # MONITORS
      monitor = cfg.monitors;

      # AUTOSTART
      exec-once = [ "${pkgs.waybar}/bin/waybar" ];

      # ENVIRONMENT VARIABLES
      env = optionals cfg.nvidia [ "WLR_NO_HARDWARE_CURSORS,1" ];

      # LOOK AND FEEL
      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 2;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "master";

        cursor_inactive_timeout = 1;
      };

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

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

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
        new_is_master = true;
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

      # KEYBINDINGS
      "$mod" = "SUPER";
      bind = let
        light = "${pkgs.light}/bin/light";
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
        grim = "${pkgs.grim}/bin/grim";
        slurp = "${pkgs.slurp}/bin/slurp";
        wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        pkill = "${pkgs.procps}/bin/pkill";
      in [
        "$mod, return, exec, ${terminal}"
        "$mod, Q, killactive,"
        "$mod, D, exec, ${menu}"
        "$mod, numbersign, exec, ${browser}"
        "$mod, Y, exec, ${browser} youtube.com"
        "$mod_SHIFT, P, exit,"
        "$mod, B, exec, ${pkill} -SIGUSR1 waybar"

        # layout commands
        "$mod_SHIFT, return, layoutmsg, swapwithmaster master"
        "$mod, tab, cyclenext,"
        "$mod, space, fullscreen, 1"
        "$mod_SHIFT, space, fakefullscreen,"

        # in-workspace movement
        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"
        "$mod, F, togglefloating, active"

        # media keys
        ", XF86MonBrightnessUp, exec, ${light} -A 5"
        ", XF86MonBrightnessDown, exec, ${light} -U 5"
        ", XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, ${playerctl} play-pause"
        ", XF86AudioNext, exec, ${playerctl} next"
        ", XF86AudioPrev, exec, ${playerctl} previous"
        '', Print, exec, ${grim} -g "$(${slurp} -d)" - | ${wl-copy}''

        # between-workspace movement
      ] ++ (concatLists (genList (x:
        let ws = toString (x + 1);
        in [
          "$mod, ${ws}, workspace, ${ws}"
          "$mod_SHIFT, ${ws}, moveToWorkspace, ${ws}"
        ]) 5));

      binde = let
        vol-step = toString cfg.keybinds.volume-step;
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
      in [
        ", XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ ${vol-step}%+"
        ", XF86AudioLowerVolume, exec, ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ ${vol-step}%-"
      ];

      bindm =
        [ "$mod,mouse:272,movewindow" "$mod_SHIFT,mouse:272,resizewindow 2" ];

      # WORKSPACES
      workspace = let
        toLine = (monitor: workspace:
          let ws = toString workspace;
          in "${ws},monitor:${monitor}");
        lists = attrValues (mapAttrs
          (monitor: workspaces: map (ws: toLine monitor ws) workspaces)
          cfg.workspaces);
      in concatLists lists;

      # LAYER RULES
      layerrule = [ "blur,waybar" "blur,rofi" ];
    };
  };
}
