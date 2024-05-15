{ pkgs-unstable, ... }: {
  imports = [ "${pkgs-unstable.path}/modules/programs/nh.nix" ];

  programs.nh.enable = true;
}
