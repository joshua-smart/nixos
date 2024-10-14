{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
in
{

  config = mkIf config.programs.zsh.enable {

    programs.zsh = {
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ".." = "cd ..";
        "ls" = "ls -F --color=auto";
        "la" = "ls -aF";
        "ll" = "ls -alFh";
        "open" = "${pkgs.xdg-utils}/bin/xdg-open";
      };

      dotDir = ".config/zsh";

      initExtra = ''
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey "^H" backward-kill-word
        bindkey "^[[3;5~" forward-kill-word
      '';
    };
  };
}
