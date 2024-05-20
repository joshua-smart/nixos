{ ... }: {
  imports = [
    ./boot.nix
    ./internationalisation.nix
    ./users.nix
    ./packages.nix
    ./display
    ./network.nix
  ];
}

