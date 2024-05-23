{ ... }: {
  programs.wofi = {
    enable = true;

    settings = {
      show = "drun";
      width = "100%";
      location = "top_left";
    };

    style = ''
      * {
        font-family: FiraCode Nerd Font Propo;
      }
    '';
  };
}
