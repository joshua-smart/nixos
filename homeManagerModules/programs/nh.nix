{ unstable }: {
  imports = [ "${unstable.path}/modules/programs/nh.nix" ];

  programs.nh.enable = true;
}
