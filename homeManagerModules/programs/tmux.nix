{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{

  config = mkIf config.programs.tmux.enable {
    programs.tmux = {

      keyMode = "vi";
      shortcut = "Space";
      escapeTime = 0;
      baseIndex = 1;
      disableConfirmationPrompt = true;
      terminal = "tmux-256color";
      mouse = true;

      extraConfig = ''
        set -ag terminal-overrides ",$TERM:Tc"
        set -g status-left-length 20
      '';

      tmuxinator.enable = true;
    };
  };
}
