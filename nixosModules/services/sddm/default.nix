{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.services.displayManager.sddm.enable {
    services.displayManager.sddm = {
      wayland.enable = true;
      theme = "${import ./sddm-sugar-dark-theme.nix { inherit pkgs; }}";
    };

    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
    ];
  };
}
