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
  };

  virtualisation.docker.enable = true;

  age.secrets."nas-credentials".file = ../../secrets/nas-credentials.age;

  # fileSystems."/home/js/Network/Public" = {
  #   device = "//192.168.1.173/Public";
  #   fsType = "cifs";
  #   options =
  #     let
  #       automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";
  #     in
  #     [
  #       automount_opts
  #       "credentials=${config.age.secrets."nas-credentials".path}"
  #       "uid=${toString config.users.users.js.uid}"
  #       "gid=${toString config.users.groups.users.gid}"
  #       "sec=ntlmssp"
  #       "dir_mode=0555"
  #       "file_mode=0444"
  #       "ro"
  #     ];
  # };
}
