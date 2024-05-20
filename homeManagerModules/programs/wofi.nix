{ ... }: {
  programs.wofi = {
    enable = true;

    settings = { };

    style = ''
      * {
        font-family: FiraCode Nerd Font Propo;
      }
    '';
  };
}
