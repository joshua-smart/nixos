{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../configuration-common.nix
  ];

  networking.firewall.allowedTCPPorts = [
    3000
    8080
  ];

  nix.flake = "/home/js/Projects/nixos";

  programs = {
    steam.enable = true;
  };

  services = {
    printing.enable = true;
    udisks2.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp.enable = true;

  age.secrets."nas-credentials".file = ../../secrets/nas-credentials.age;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;
}
