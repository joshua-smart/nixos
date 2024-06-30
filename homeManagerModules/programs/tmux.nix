{ ... }: {
  programs.tmux = {
    enable = true;

    keyMode = "vi";
    shortcut = "Space";
    escapeTime = 0;
    baseIndex = 1;

    terminal = "tmux-256color";

    extraConfig = ''
      set -ag terminal-overrides ",$TERM:Tc"
    '';
  };
}
