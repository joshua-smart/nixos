{ ... }:
{
  programs.tmux = {
    enable = true;

    keyMode = "vi";
    shortcut = "Space";
    escapeTime = 0;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    terminal = "tmux-256color";
    mouse = true;

    extraConfig = ''
      set -ag terminal-overrides ",$TERM:Tc"
    '';
  };
}
