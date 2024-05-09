{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 12;
        normal = { family = "FiraCode Nerd Font Mono"; };
      };
      window.padding = {
        x = 4;
        y = 4;
        opacity = 0.6;
        title = "Terminal";
      };
      colors = {
        # Default colors
        primary = {
          background = "#2D2A2E";
          foreground = "#fff1f3";
        };

        # Normal colors
        normal = {
          black = "#2c2525";
          red = "#fd6883";
          green = "#adda78";
          yellow = "#f9cc6c";
          blue = "#f38d70";
          magenta = "#a8a9eb";
          cyan = "#85dacc";
          white = "#fff1f3";
        };

        # Bright colors
        bright = {
          black = "#72696a";
          red = "#fd6883";
          green = "#adda78";
          yellow = "#f9cc6c";
          blue = "#f38d70";
          magenta = "#a8a9eb";
          cyan = "#85dacc";
          white = "#fff1f3";
        };
      };
    };
  };
}
