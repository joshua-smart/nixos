{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkOption
    types
    lists
    attrsets
    ;
  cfg = config.wayland.windowManager.hyprland;
in
{
  options.wayland.windowManager.hyprland.keybinds = {
    volume-step = mkOption {
      type = types.int;
      default = 1;
      description = ''
        Percentage to increase volume by
      '';
    };
  };

  config = mkIf cfg.enable {

    wayland.windowManager.hyprland.settings = {
      # KEYBINDINGS
      "$mod" = "SUPER";
      bind =
        let
          terminal = "${pkgs.alacritty}/bin/alacritty";
          browser = "${pkgs.firefox}/bin/firefox";
          light = "${pkgs.light}/bin/light";
          wpctl = "${pkgs.wireplumber}/bin/wpctl";
          grim = "${pkgs.grim}/bin/grim";
          slurp = "${pkgs.slurp}/bin/slurp";
          wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
          playerctl = "${pkgs.playerctl}/bin/playerctl";
          pkill = "${pkgs.procps}/bin/pkill";
          rofi = "${pkgs.rofi-wayland}/bin/rofi";
        in
        [
          "$mod, return, exec, ${terminal}"
          "$mod, Q, killactive,"
          "$mod, D, exec, ${rofi} -show drun"
          "$mod, S, exec, ${rofi} -show ssh"
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
          ''SHIFT, Print, exec, ${grim} -g "$(${slurp} -d)" ${config.xdg.userDirs.pictures}/Screenshot_$(date -Iseconds).png''

          # between-workspace movement
        ]
        ++ (
          let
            inherit (lists) unique flatten;
            inherit (attrsets) attrValues;
            usedWorkspaces = map toString (unique (flatten (attrValues cfg.workspaces)));
          in
          lists.concatMap (ws: [
            "$mod, ${ws}, workspace, ${ws}"
            "$mod_SHIFT, ${ws}, moveToWorkspace, ${ws}"
          ]) usedWorkspaces
        );

      binde =
        let
          vol-step = toString cfg.keybinds.volume-step;
          wpctl = "${pkgs.wireplumber}/bin/wpctl";
        in
        [
          ", XF86AudioRaiseVolume, exec, ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ ${vol-step}%+"
          ", XF86AudioLowerVolume, exec, ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ ${vol-step}%-"
        ];

      bindm = [
        "$mod,mouse:272,movewindow"
        "$mod_SHIFT,mouse:272,resizewindow 2"
      ];
    };
  };

}
