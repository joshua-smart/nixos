{ ... }: {
  programs.gnupg = {
    enable = true;
    pinentryFlavour = "curses";
    enableSSHSupport = true;
  };
}
