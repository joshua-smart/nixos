{ pkgs, ... }: {
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    # MONITORS
    monitor = ",prefered,auto,0.8";

    # PROGRAMS
    "$terminal" = "${pkgs.alacritty}/bin/alacritty";
    "$browser" = "${pkgs.firefox}/bin/firefox";
    "$fileManager" = "${pkgs.dolphin}/bin/dolphin";
    "$menu" = "${pkgs.wofi}/bin/wofi --show drun";

    # AUTOSTART
    exec-once = [ "$terminal" ];

    # ENVIRONMENT VARIABLES
    env = [ ];

    # LOOK AND FEEL
    general = {
      gaps_in = 5;
      gaps_out = 20;

      border_size = 2;

      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      resize_on_border = false;

      allow_tearing = false;

      layout = "dwindle";
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
        size = 3;
        passes = 1;

        vibrancy = 0.1696;
      };
    };

    animations = {
      enabled = true;

      # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = { new_is_master = true; };

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

    gestures = { workspace_swipe = false; };

    # KEYBINDINGS
    "$mod" = "SUPER";
    bind = [
      "$mod, RETURN, exec, $terminal"
      "$mod, Q, killactive,"
      "$mod, D, exec, $menu"
      "$mod, numbersign, exec, $browser"
      "$mod_SHIFT, Q, exit,"
    ];
  };
}
