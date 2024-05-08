{ ... }: {
  programs.bash = {
    promptInit =
      "[033[38;5;41m]u@h[$(tput sgr0)]:[$(tput sgr0)][033[38;5;33m]W[$(tput sgr0)] [$(tput sgr0)][033[38;5;33m]\\$[$(tput sgr0)] [$(tput sgr0)]";
  };
}
