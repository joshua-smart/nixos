{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
in
{
  options.profiles.desktop-apps.enable = mkEnableOption "desktop apps profile";

  config = mkIf config.profiles.desktop-apps.enable {
    programs = {
      kitty.enable = true;
      alacritty.enable = true;
      discord.enable = true;
      firefox.enable = true;
      thunderbird.enable = true;
      vscode.enable = true;
    };

    home.packages = with pkgs; [
      obsidian
      slack
      zulip
      spotify
    ];
  };
}
