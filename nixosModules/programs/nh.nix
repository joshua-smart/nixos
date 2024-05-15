{ pkgs-unstable, ... }: {
  imports = [ "${pkgs-unstable.path}/nixos/modules/programs/nh.nix" ];

  programs.nh.enable = true;
}
