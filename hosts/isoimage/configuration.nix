{ modulesPath, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../../nixosModules
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  profiles = {
    boot.enable = true;
    localisation.enable = true;
    users.enable = true;
  };

  programs = {
    zsh.enable = true;
  };

  services = {
    openssh.enable = true;
  };
}
