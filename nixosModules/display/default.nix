{ pkgs, ... }: {
  imports = [ ./sddm.nix ];

  services.xserver = {
    enable = true;
    excludePackages = with pkgs; [ xterm ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.light.enable = true;
}
