{ lib, config, ... }:
with lib;
let cfg = config.display.bar;
in {

  options.display.bar = {
    workspaces = mkOption { type = types.listOf types.int; };
    monitors = mkOption { type = types.listOf types.str; };
  };

  config = {

    programs.waybar = {
      enable = true;

      settings = {
        main = {
          layer = "top";
          spacing = 0;

          output = cfg.monitors;

          modules-left = [ "hyprland/workspaces" "hyprland/window" ];
          modules-center = [ "clock" ];
          modules-right = [
            "disk"
            "cpu"
            "memory"
            "backlight"
            "battery"
            "pulseaudio"
            "network"
            "tray"
          ];

          # Left modules
          "hyprland/workspaces" = {
            persistent-workspaces = { "*" = cfg.workspaces; };
          };
          "hyprland/window" = {
            format = "{title}";
            rewrite = {
              "(.*) - YouTube — Mozilla Firefox" = " $1";
              "(.*) · GitHub — Mozilla Firefox" = " $1";
              "(.*) — Mozilla Firefox" = " $1";
              "(.*) - Discord" = "󰙯 $1";
              "Mozilla Firefox" = "";
              "Terminal" = "";
            };
          };

          # Center modules
          clock = {
            format = "{:%H:%M}";
            format-alt = "{:%d-%m-%Y :%H:%M:%S}";
            interval = 1;
          };

          # Right modules
          disk = { format = " {percentage_used}%"; };
          cpu = { format = " {usage}%"; };
          memory = { format = " {percentage}%"; };
          backlight = { format = " {percent}%"; };
          battery = {
            format = "{icon} {capacity}%";
            format-icons = [ "" "" "" "" "" ];
          };
          pulseaudio = {
            format = "{icon} {volume}%";
            format-bluetooth = "{icon} {volume}% ";
            format-muted = " muted";
            format-icons = { default = [ "" "" "" ]; };
          };
          network = {
            format = " {essid} {ipaddr}";
            format-disconnected = " disconnected";
          };
          tray = {
            spacing = 9;
            icon-size = 18;
          };
        };
      };

      style = ./style.css;
    };
  };
}
