{ lib, config, ... }:
with lib;
let
  cfg = config.programs.waybar;
in
{

  options.programs.waybar = {
    workspaces = mkOption { type = types.listOf types.int; };
    monitors = mkOption { type = types.listOf types.str; };
    modules = mkOption { type = types.listOf types.str; };
  };

  config = mkIf cfg.enable {

    programs.waybar = {
      systemd.enable = true;

      settings =
        let
          sep = "custom/separator";
        in
        {
          main = {
            layer = "top";
            spacing = 0;

            output = cfg.monitors;

            modules-left = strings.intersperse sep [
              "hyprland/workspaces"
              "hyprland/window"
            ];
            modules-center = [ "clock" ];
            modules-right = strings.intersperse sep cfg.modules;

            # Separator
            "custom/separator" = {
              format = "|";
              interval = "once";
              tooltip = false;
            };

            # Left modules
            "hyprland/workspaces" = {
              persistent-workspaces = {
                "*" = cfg.workspaces;
              };
            };
            "hyprland/window" = {
              format = "{title}";
              rewrite = {
                "(.*) - YouTube — Mozilla Firefox" = " $1";
                "(.*) · GitHub — Mozilla Firefox" = " $1";
                "(.*) — Mozilla Firefox" = "󰈹 $1";
                "(.*) - Discord" = "󰙯 $1";
                "Mozilla Firefox" = "󰈹";
                "(.*) - Terminal" = " $1";
              };
            };

            # Center modules
            clock = {
              format = "{:%H:%M}";
              format-alt = "{:%d-%m-%Y %H:%M:%S}";
              interval = 1;
            };

            # Right modules
            disk = {
              format = " {percentage_used}%";
            };
            cpu = {
              format = " {usage}%";
            };
            memory = {
              format = " {percentage}%";
            };
            backlight = {
              format = " {percent}%";
            };
            battery = {
              format = "{icon} {capacity}%";
              format-charging = "󰂄 {capacity}%";
              format-icons = [
                "󰂎"
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };
            pulseaudio = {
              format = "{icon} {volume}%";
              format-bluetooth = "{icon} {volume}% ";
              format-muted = " muted";
              format-icons = {
                default = [
                  ""
                  ""
                  ""
                ];
              };
            };
            network = {
              format-ethernet = " {ipaddr}";
              format-wifi = " {essid} {ipaddr}";
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
