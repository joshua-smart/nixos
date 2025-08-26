{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../nixosModules
  ];

  networking.firewall.allowedTCPPorts = [
    3000
    8080
  ];

  nix.flake = "/home/js/Projects/nixos";

  age.secrets."root-hashed-password".file = ../../secrets/laptop-root-hashed-password.age;

  profiles = {
    boot.enable = true;
    display.enable = true;
    localisation.enable = true;
    network = {
      enable = true;
      wireguard-patch = false;
    };
    sound.enable = true;
    users = {
      enable = true;
      rootHashedPasswordFile = config.age.secrets."root-hashed-password".path;
    };
    power-management.enable = true;
    bluetooth.enable = true;
  };

  programs = {
    zsh.enable = true;
    steam.enable = true;
  };

  services = {
    openssh.enable = true;
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

  age.secrets."nas-credentials".file = ../../secrets/nas-credentials.age;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;
}
