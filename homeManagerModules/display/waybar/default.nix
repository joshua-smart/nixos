{ lib, config, ... }:
with lib;
let cfg = config.display.bar;
in {

  options.display.bar = {
    workspaces = mkOption { type = types.listOf types.int; };
    monitors = mkOption { type = types.listOf types.str; };
    network-type = mkOption { type = types.str; };
    modules = mkOption { type = types.listOf types.str; };
  };

  config = {

    programs.waybar = {
      enable = true;

      settings = let sep = "custom/separator";
      in {
        main = {
          layer = "top";
          spacing = 0;

          output = cfg.monitors;

          modules-left =
            strings.intersperse sep [ "hyprland/workspaces" "hyprland/window" ];
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
            persistent-workspaces = { "*" = cfg.workspaces; };
          };
          "hyprland/window" = {
            format = "{title}";
            rewrite = {
              "(.*) - YouTube — Mozilla Firefox" = " $1";
              "(.*) · GitHub — Mozilla Firefox" = " $1";
              "(.*) — Mozilla Firefox" = " $1";
              "(.*) - Discord" = "󰙯 $1";
              "Mozilla Firefox" = "󰈹";
              "Terminal" = "";
            };
          };

          # Center modules
          clock = {
            format = "{:%H:%M}";
            format-alt = "{:%d-%m-%Y %H:%M:%S}";
            interval = 1;
          };

          # Right modules
          disk = { format = " {percentage_used}%"; };
          cpu = { format = " {usage}%"; };
          memory = { format = " {percentage}%"; };
          backlight = { format = " {percent}%"; };
          battery = {
            format = "{icon} {capacity}%";
            format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          };
          pulseaudio = {
            format = "{icon} {volume}%";
            format-bluetooth = "{icon} {volume}% ";
            format-muted = " muted";
            format-icons = { default = [ "" "" "" ]; };
          };
          network = {
            format = if cfg.network-type == "wired" then
              " {ipaddr}"
            else if cfg.network-type == "wireless" then
              " {essid} {ipaddr}"
            else
              abort "unrecognised network type";
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
