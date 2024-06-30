{ ... }:
{
  imports = [ ./udiskie.nix ];
  services = {
    network-manager-applet.enable = true;
    swaync.enable = true;
  };
}
