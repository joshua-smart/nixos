# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs-unstable, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../nixosModules
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    package = (pkgs-unstable.linuxPackagesFor
      config.boot.kernelPackages.kernel).nvidiaPackages.beta;
  };
  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
}
