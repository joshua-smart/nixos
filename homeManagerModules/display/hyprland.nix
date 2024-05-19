{ pkgs, ... }: {
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    # MONITORS
    monitor = ",prefered,auto,1";

    # PROGRAMS
    "$terminal" = "${pkgs.alacritty}/bin/alacritty";
    "$browser" = "${pkgs.firefox}/bin/firefox";
    "$fileManager" = "${pkgs.dolphin}/bin/dolphin";
    "$menu" = "${pkgs.wofi}/bin/wofi --show drun";

    # AUTOSTART
    exec-once =
      [ "${pkgs.hyprpaper}/bin/hyprpaper" "${pkgs.waybar}/bin/waybar" ];

    # ENVIRONMENT VARIABLES
    env = [ ];

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
        size = 5;
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
    bind = [
      "$mod, return, exec, $terminal"
      "$mod, Q, killactive,"
      "$mod, D, exec, $menu"
      "$mod, numbersign, exec, $browser"
      "$mod_SHIFT, P, exit,"

      # layout commands
      "$mod_SHIFT, return, layoutmsg, swapwithmaster master"
      "$mod, tab, cyclenext,"
      "$mod, space, fullscreen, 0"

      # in-workspace movement
      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, r"

      # media keys
      ", XF86MonBrightnessUp, exec, light -A 5"
      ", XF86MonBrightnessDown, exec, light -U 5"
      ''
        , Print, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.wl-clipboard}/bin/wl-copy''

      # between-workspace movement
    ] ++ (builtins.concatLists (builtins.genList (x:
      let ws = builtins.toString (x + 1);
      in [
        "$mod, ${ws}, workspace, ${ws}"
        "$mod_SHIFT, ${ws}, moveToWorkspace, ${ws}"
      ]) 5));

    # WORKSPACES
    workspace = builtins.genList
      (x: let ws = builtins.toString (x + 1); in "${ws},monitor:eDP-1") 5;
  };
}
