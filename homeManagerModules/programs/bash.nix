{ ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      "ls" = "ls -F --color=auto";
      "la" = "ls -aF";
      "ll" = "ls -alFh";
    };
  };
}
