{ ... }: {

  programs.waybar = {
    enable = true;

    settings = {
      main = {
        layer = "top";
        spacing = 0;

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
        "hyprland/workspaces" = { persistent-workspaces = { "*" = 5; }; };
        "hyprland/window" = {
          format = "{title}";
          rewrite = {
            "(.*) - YouTube — Mozilla Firefox" = " $1";
            "(.*) · GitHub — Mozilla Firefox" = " $1";
            "(.*) — Mozilla Firefox" = " $1";
            "(.*) - Discord" = " $1";
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

    style = ''
      @define-color bg-0 #222222;
      @define-color bg-1 #363636;
      @define-color bg-2 #555555;

      @define-color fg-0 #cccccc;

      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FiraCode Nerd Font Propo;
          font-size: 14px;
      }

      window#waybar {
          background-color: alpha(@bg-0, 0.9);
          color: @fg-0;
      }

      widget {}

      label {
          background-color: @bg-1;
          color: @fg-0;
          padding: 0 0.6rem;
      }

      /* workspaces */

      box#workspaces {
          background: @bg-0;
          margin: 0.6rem 0.3rem;
          margin-left: 0.6rem;
      }

      #workspaces button {
          padding: 0 0;
          margin: 0 0;
          background: @bg-0;
          border-radius: 0;
      }

      #workspaces button:hover {
          background: @bg-0;
          box-shadow: none;
          border: none;
      }

      #workspaces button.active label {
          border-bottom: 3px solid @fg-0;
          padding-top: 3px;
      }

      #workspaces button label {
          background: @bg-2;
      }

      #workspaces button.empty label {
          background: @bg-1;
      }

      button {
          border: unset;
      }

      #window,
      #clock,
      #disk,
      #cpu,
      #memory,
      #backlight,
      #battery,
      #pulseaudio,
      #network,
      #tray {
          margin: 0.6rem 0.3rem;
      }

      #tray {
          margin-right: 0.6rem;
      }
    '';
  };
}
