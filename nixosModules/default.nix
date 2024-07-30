{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
{
  imports = [
    ./programs
    ./services
    ./profiles
  ];

  options.nix.flake = mkOption {
    type = types.str;
    default = "/etc/nixos";
    description = "Location of this system flake on the host machine";
  };

  config = {
    environment.systemPackages = with pkgs; [ helix ];

    environment.variables = {
      FLAKE = config.nix.flake;
      EDITOR = "hx";
    };

    system.stateVersion = "23.11";
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
