{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.kitty.enable {
    programs.kitty = {
      themeFile = "Doom_One";
      font = {
        package = pkgs.nerd-fonts.fira-code;
        name = "family=\"FiraCode Nerd Font\" style=\"Light\"";
        size = 12;
      };
      settings = {
        cursor_shape = "block";
        cursor_blink_interval = 0;
        background_opacity = 0.7;
        foreground = "#eeeeee";
        disable_ligatures = "always";
        window_padding_width = 2;
      };
      shellIntegration = {
        mode = "no-cursor";
        enableZshIntegration = true;
      };
    };

    home.packages = with pkgs; [ viu ];
  };
}
