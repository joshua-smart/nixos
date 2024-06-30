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

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    package =
      let
        kernel = config.boot.kernelPackages.kernel;
        kernelPackages = pkgs.unstable.linuxPackagesFor kernel;
      in
      kernelPackages.nvidiaPackages.beta;
  };
  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
}
