{ pkgs, ... }:
let
  theme = "doom_one";
  theme_file =
    pkgs.fetchFromGitHub {
      owner = "alacritty";
      repo = "alacritty-theme";
      rev = "a4041ae";
      sha256 = "sha256-A5Xlu6kqB04pbBWMi2eL+pp6dYi4MzgZdNVKztkJhcg=";
    }
    + "/themes/${theme}.toml";
in
{
  programs.alacritty = {
    enable = true;

    settings = {
      import = [ "~/.config/alacritty/theme.toml" ];

      font = {
        size = 12;
        normal = {
          family = "FiraCode Nerd Font Propo";
        };
      };
      window = {
        padding = {
          x = 4;
          y = 4;
        };
        opacity = 0.6;
        title = "Terminal";
      };

      env = {
        TERM = "xterm-256color";
      };
    };
  };

  xdg.configFile."alacritty/theme.toml".source = theme_file;
}
