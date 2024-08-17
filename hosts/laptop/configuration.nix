# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, ... }:

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

  # Fix for internal sound devices
  boot.kernelParams = [ "snd-intel-dspcfg.dsp_driver=1" ];

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

  age.secrets."nas-credentials".file = ../../secrets/nas-credentials.age;

  fileSystems."/home/js/Network/Public" = {
    device = "//192.168.1.173/Public";
    fsType = "cifs";
    options =
      let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
      in
      [
        automount_opts
        "credentials=${config.age.secrets."nas-credentials".path}"
        "uid=${toString config.users.users.js.uid}"
        "gid=${toString config.users.groups.users.gid}"
        "sec=ntlmssp"
        "dir_mode=0555"
        "file_mode=0444"
        "ro"
      ];
  };
}
