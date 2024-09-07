{ user, config, ... }:
{
  imports = [
    ./programs
    ./services
    ./scripts
    ./profiles
    ./gtk
    ./windowManagers
  ];
  home.username = user;
  home.homeDirectory = "/home/${user}";
  xdg.userDirs.pictures = "${config.home.homeDirectory}/Images";

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
