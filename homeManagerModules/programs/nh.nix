{ ... }@inputs: {
  imports = [ "${inputs.unstable.path}/modules/programs/nh.nix" ];

  programs.nh.enable = true;
}
