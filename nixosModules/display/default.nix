{ pkgs, ... }: {
  services.xserver.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "${import ./sddm-sugar-dark-theme.nix { inherit pkgs; }}";
  };

  programs.light.enable = true;
}
