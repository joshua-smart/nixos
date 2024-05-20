{ ... }: {
  imports = [ ./sddm.nix ];

  services.xserver.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.light.enable = true;
}
