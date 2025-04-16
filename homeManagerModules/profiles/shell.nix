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
  options.profiles.shell.enable = mkEnableOption "shell profile";

  config = mkIf config.profiles.shell.enable {

    programs = {
      zsh.enable = true;
      oh-my-posh.enable = true;
      git.enable = true;
      gitui.enable = true;
      tmux.enable = true;
      helix.enable = true;
      direnv.enable = true;
      ssh.enable = true;
    };

    home.packages = with pkgs; [
      nh
      tree
      zip
      unzip
      myPackages.nr
    ];
  };
}
