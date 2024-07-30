{ pkgs, lib, config, ... }:
with lib;
let
  theme_name = "doom_one";
  theme_base = fromTOML (
    builtins.readFile (
      pkgs.fetchFromGitHub {
        owner = "alacritty";
        repo = "alacritty-theme";
        rev = "a4041ae";
        sha256 = "sha256-A5Xlu6kqB04pbBWMi2eL+pp6dYi4MzgZdNVKztkJhcg=";
      }
      + "/themes/${theme_name}.toml"
    )
  );
  theme = recursiveUpdate theme_base { colors.primary.foreground = "#eeeeee"; };
in
{
  config = mkIf programs.alacritty.enable {

    programs.alacritty = {

      settings = {
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
      } // theme;
    };
  };
}
