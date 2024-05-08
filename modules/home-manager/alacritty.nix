{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 8;
      window.padding = {
        x = 4;
        y = 4;
        opacity = 0.6;
        title = "Terminal";
      };
      shell.program = "${pkgs.bash}/bin/bash";
    };
  };
}
