{ ... }: {
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/background.jpg
    wallpaper = eDP-1,~/.config/hypr/background.jpg
  '';
  home.file.".config/hypr/background.jpg".source = ./background.jpg;
}
