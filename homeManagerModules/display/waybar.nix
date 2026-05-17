{ lib, config, ... }:
let
  inherit (lib)
    mkOption
    types
    strings
    ;
  cfg = config.programs.waybar;
  modulesList = strings.splitString "," cfg.modules;
in
{

  options.programs.waybar = {
    workspaces = mkOption { type = types.listOf types.int; };
    monitors = mkOption { type = types.listOf types.str; };
    modules = mkOption {
      type = types.str;
      description = ''
        comma-separated list of modules to include
      '';
    };
  };

  config = {

    services.playerctld.enable = builtins.elem "mpris" modulesList;

    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
        target = config.wayland.systemd.target;
      };
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
            modules-right = strings.intersperse sep modulesList;

            # Separator
            "custom/separator" = {
              format = "|";
              interval = "once";
              tooltip = false;
            };

            # Left modules
            "hyprland/workspaces" = {
              persistent-workspaces = {
                "*" = [
                  1
                  2
                ];
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
              tooltip-format = "{calendar}";
              calendar = {
                mode = "month";
                format = {
                  today = "<b><u>{}</u></b>";
                };
              };
            };

            # Right modules
            mpris = {
              format = "{status_icon} {dynamic}";
              status-icons = {
                paused = "";
                playing = "";
              };
              dynamic-order = [
                "title"
                "artist"
              ];
              interval = 1;
              ignored-players = [ "firefox" ];
            };
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
              family = "ipv4_6";
              format-ethernet = " {ipaddr}";
              format-wifi = " {essid} {ipaddr}";
              format-disconnected = " disconnected";
              max-length = 32;
            };
            tray = {
              spacing = 9;
              icon-size = 18;
            };
          };
        };

      style = ./waybar-style.css;
    };
  };
}
