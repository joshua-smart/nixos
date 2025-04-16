{
  user,
  config,
  lib,
  ...
}:
let
  inherit (lib) fileset;

  modulesInDirectory = dir: fileset.toList (fileset.fileFilter (file: file.hasExt "nix") dir);
in
{
  imports =
    [
      ./gtk.nix
      ./windowManagers
    ]
    ++ builtins.concatMap modulesInDirectory [
      ./services
      ./programs
      ./profiles
    ];
  home.username = user;
  home.homeDirectory = "/home/${user}";
  xdg.userDirs.pictures = "${config.home.homeDirectory}/Images";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
