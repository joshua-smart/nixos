{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
in
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
      NH_FLAKE = config.nix.flake;
      EDITOR = "hx";
    };

    system.stateVersion = "23.11";
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
