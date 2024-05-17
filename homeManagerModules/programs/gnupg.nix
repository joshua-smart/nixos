{ pkgs, ... }: {
  programs.gpg.enable = true;
  services.gpg-agent.pinentryPackage = pkgs.pinentry-curses;
}
