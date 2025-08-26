# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../nixosModules
  ];

  virtualisation.docker.enable = true;

  networking.firewall.allowedTCPPorts = [
    3000
    8080
  ];

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
    steam.enable = true;
  };

  services = {
    openssh.enable = true;
    printing.enable = true;
    udisks2.enable = true;
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;
}
