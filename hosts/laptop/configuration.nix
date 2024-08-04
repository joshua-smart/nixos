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

  networking.firewall.allowedTCPPorts = [ 3000 ];

  nix.flake = "/home/js/Projects/nixos";

  profiles = {
    boot.enable = true;
    display.enable = true;
    localisation.enable = true;
    network.enable = true;
    sound.enable = true;
    users.enable = true;
  };

  programs = {
    zsh.enable = true;
  };

  services = {
    openssh.enable = true;
    printing.enable = true;
    udisks2.enable = true;
  };

  virtualisation.docker.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Power management
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services.thermald.enable = true;
  services.tlp.enable = true;
}
