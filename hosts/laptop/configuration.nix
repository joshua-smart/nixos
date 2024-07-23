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

  key-remapping = ''
    (defsrc
      caps
      f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12
      mute vold volu brdn brup
    )

    (defalias
      escctrl (tap-hold 100 100 esc lctrl)
    )

    (deflayer base
      @escctrl
      mute vold volu brdn brup _ _ _ _ _ _ _
      f1 f2 f3 f4 f5
    )
  '';
}
