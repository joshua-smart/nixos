{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../configuration-common.nix
    ./keymap.nix
  ];

  networking.firewall.allowedTCPPorts = [
    3000
    8080
  ];

  sops.defaultSopsFile = ./secrets.yaml;

  nix.flake = "/home/js/Projects/nixos";

  programs = {
    steam.enable = true;
    # wireshark.enable = true;
  };

  # users.users.js.extraGroups = [ "wireshark" ];

  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "js" ];
  # boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  # environment.systemPackages = with pkgs; [
  #   displaylink
  # ];
  # services.xserver.videoDrivers = [
  #   "displaylink"
  #   "modesetting"
  # ];
  # boot = {
  #   extraModulePackages = [ config.boot.kernelPackages.evdi ];
  #   initrd = {
  #     # List of modules that are always loaded by the initrd.
  #     kernelModules = [
  #       "evdi"
  #     ];
  #   };
  # };

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

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;
}
