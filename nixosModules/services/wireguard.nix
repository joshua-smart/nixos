{ config, lib, ... }:
with lib;
{

  # Public key: fzo3OXiMWLDbsu6siSOlU+fAFxb3Z+ChNai/skhnxHo=

  options.services.wireguard.enable = mkEnableOption "wireguard";

  config = mkIf config.services.wireguard.enable {

    age.secrets."wireguard-private-key".file = ../../secrets/wireguard-private-key.age;

    networking.firewall.allowedUDPPorts = [ 51820 ];
    networking.useNetworkd = true;

    systemd.network = {
      enable = true;
      netdevs = {
        "50-wg0" = {
          netdevConfig = {
            Kind = "wireguard";
            Name = "wg0";
            MTUBytes = "1300";
          };
          wireguardConfig = {
            PrivateKeyFile = config.age.secrets."wireguard-private-key".path;
            ListenPort = 51820;
          };
          wireguardPeers = [
            {
              wireguardPeerConfig = {
                PublicKey = "Jw6gdMp9qEhksETONpGCBY11qyyyGGjV7eLOyKWHbCs=";
                AllowedIPs = [ "10.100.0.2" ];
              };
            }
          ];
        };
      };
      networks.wg0 = {
        matchConfig.Name = "wg0";
        address = [ "10.100.0.1/24" ];
        networkConfig = {
          IPMasquerade = "ipv4";
          IPForward = true;
        };
      };
    };
  };
}
