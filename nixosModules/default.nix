{ ... }: {
  imports = [
    ./boot.nix
    ./internationalisation.nix
    ./users.nix
    ./packages.nix
    ./display.nix
    ./network.nix
    ./programs
  ];
}

