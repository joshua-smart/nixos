# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../configuration-common.nix
  ];

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  networking.firewall.allowedTCPPorts = [
    3000
    8080
  ];

  environment.systemPackages = with pkgs; [
    wireguard-tools
    protonvpn-gui
    wireshark
    openssl.dev
    openssl
  ];

  programs.wireshark.enable = true;
  users.users.js.extraGroups = [ "wireshark" ];

  nix.flake = "/home/js/Projects/nixos";

  programs = {
    steam.enable = true;
  };

  services = {
    printing.enable = true;
    udisks2.enable = true;
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
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

  # Audio crackling fix
  services.pipewire.extraConfig.pipewire."0-cracking-fix" = {
    "default.clock.min-quantum" = 1024;
  };

  # Keymap
  services.kanata = {
    enable = true;
    keyboards."default".config = ''
      (defsrc caps f1 mute)
      (deflayer default esc mute f1)
    '';
  };

}
