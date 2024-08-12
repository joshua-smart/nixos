{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
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
    };

    home.packages = with pkgs; [
      nh
      tree
      deploy-rs
    ];
  };
}
