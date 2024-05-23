{ ... }: {
  imports = [
    ./boot.nix
    ./internationalisation.nix
    ./users.nix
    ./display
    ./network.nix
    ./programs
  ];
}

