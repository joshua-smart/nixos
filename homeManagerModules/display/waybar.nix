{ ... }: {

  programs.waybar = {
    enable = true;

    settings = {
      "height" = 44;
      "spacing" = 10;

      "modules-left" = [ "hyprland/workspaces" "hyprland/window" ];
      "modules-center" = [ "clock" ];
      "modules-right" =
        [ "cpu" "memory" "backlight" "battery" "pulseaudio" "network" "tray" ];

      # Left modules
      "hyprland/workspaces" = { "persistent-workspaces" = { "*" = 5; }; };
      "hyprland/window" = { "format" = "{title}"; };

      # Center modules
      "clock" = {
        "format" = "{ =%H =%M}";
        "format-alt" = "{ =%d-%m-%Y %H =%M =%S}";
        "interval" = 1;
      };

      # Right modules
      "cpu" = { "format" = " {usage}%"; };
      "memory" = { "format" = " {percentage}%"; };
      "backlight" = { "format" = " {percent}%"; };
      "battery" = {
        "format" = "{icon} {capacity}%";
        "format-icons" = [ "" "" "" "" "" ];
      };
      "pulseaudio" = {
        "format" = "{icon} {volume}%";
        "format-bluetooth" = "{icon} {volume}% ";
        "format-muted" = " muted";
        "format-icons" = { "default" = [ "" "" "" ]; };
      };
      "network" = { "format" = " {essid} {ipaddr}"; };
    };

    style = ''
            
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FiraCode Nerd Font Propo;
          font-size: 14px;
      }

      window#waybar {
          background-color: rgba(34, 34, 34, 0.9);
          color: #cccccc;
          transition-property: background-color;
          transition-duration: .5s;
      }

      widget {}

      label {
          background-color: #363636;
          color: #cccccc;
          padding: 4px 10px;
          margin: 6px 3px;
      }

      /* workspaces */

      box#workspaces {
          background: #222222;
      }

      #workspaces button {
          padding: 0 0;
          margin: 0 0;
          background: #222222;
          border-radius: 0;
      }

      #workspaces button:hover {
          background: #222222;
          box-shadow: none;
          border: none;
      }

      #workspaces button.active label {
          border-bottom: 3px solid #cccccc;
          padding: 7px 10px 4px 10px;
      }

      #workspaces button label {
          background: #555555;
          margin: 6px -1px;
      }

      #workspaces button.empty label {
          background: #363636;
      }

      #pulseaudio label {
          background: transparent;
      }
    '';
  };
}
