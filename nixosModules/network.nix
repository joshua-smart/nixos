{ lib, config, ... }:
with lib; {

  options.hostname = mkOption { type = types.str; };

  config = {
    networking.hostName = config.hostname; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    networking.firewall.allowedUDPPorts = [ 5353 ];
  };

}
