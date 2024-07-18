{ modulesPath, lib, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../../nixosModules
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.networkmanager.enable = lib.mkForce false;
}
