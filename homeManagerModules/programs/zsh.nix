{ ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ".." = "cd ..";
      "ls" = "ls -F --color=auto";
      "la" = "ls -aF";
      "ll" = "ls -alFh";
    };

    dotDir = ".config/zsh";

    initExtra = ''
      bindkey ";5C" forward-word
      bindkey ";5D" backward-word
    '';
  };
}
