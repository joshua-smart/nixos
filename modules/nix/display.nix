{ ... }: {
  services.xserver.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.xserver.displayManager.gdm.enable = true;
}
