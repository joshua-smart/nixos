# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../nixosModules
  ];

  nix.flake = "/home/js/nixos";

  profiles = {
    boot.enable = true;
    localisation.enable = true;
    users.enable = true;
  };

  networking.hostName = "server";

  programs = {
    zsh.enable = true;
  };

  services = {
    openssh.enable = true;
    wireguard.enable = true;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      v5-minecraft = {
        image = "itzg/minecraft-server";
        ports = [ "25566:25565" ];
        environment = {
          EULA = "true";
          MEMORY = "4G";
          TYPE = "PAPER";
          VERSION = "1.21";
        };
        volumes = [ "/home/js/containers/v5-minecraft:/data" ];
      };

      v5-minecraft-backup = {
        image = "itzg/mc-backup";
        environment = {
          BACKUP_INTERVAL = "1d";
          INITIAL_DELAY = "0";
        };
        volumes = [
          "/home/js/containers/v5-minecraft:/data:ro"
          "/home/js/containers/v5-minecraft-backups:/backups"
        ];
        dependsOn = [ "v5-minecraft" ];
        extraOptions = [ "--network=container:v5-minecraft" ];
      };

      gandi-dynamic-dns = {
        image = "adamvig/gandi-dynamic-dns";
        environment = {
          GANDI_API_KEY = "Ze6YbThzV1jMPr6PuwM4a7Uf";
          DOMAIN = "jsmart.dev";
          RECORD_NAME = "@";
          UPDATE_INTERVAL = "15m";
        };
      };

      nginx-proxy-manager = {
        image = "jc21/nginx-proxy-manager";
        ports = [
          "80:80"
          "443:443"
        ];
        volumes = [
          "/home/js/containers/nginx-proxy-manager/data:/data"
          "/home/js/containers/nginx-proxy-manager/letsencrypt:/etc/letsencrypt"
        ];
        extraOptions = [ "--network=proxy" ];
      };

      static-file-server = {
        image = "halverneus/static-file-server";
        volumes = [ "/home/js/containers/static-file-server:/web" ];
        extraOptions = [ "--network=proxy" ];
      };
    };
  };
}
