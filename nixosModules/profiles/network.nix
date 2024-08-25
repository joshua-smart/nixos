{
  config,
  lib,
  host,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkOption
    optionals
    types
    mkIf
    ;
  cfg = config.profiles.network;
in
{
  options.profiles.network = {
    enable = mkEnableOption "network profile";
    spotify-network-devices = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Open port to allow spotify to connect to network devices
      '';
    };
    wireguard-patch = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Patch iptables to allow wireguard VPN
      '';
    };
  };

  config = mkIf cfg.enable {
    networking.hostName = host;

    networking.networkmanager.enable = true;

    networking.firewall =
      {
        # Spotify network devices
        allowedUDPPorts = optionals cfg.spotify-network-devices [ 5353 ];
      }
      // mkIf cfg.wireguard-patch {

        ## Wireguard patch
        # if packets are still dropped, they will show up in dmesg
        logReversePathDrops = true;
        # wireguard trips rpfilter up
        extraCommands = ''
          ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
          ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
        '';
        extraStopCommands = ''
          ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
          ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
        '';
      };
  };
}
