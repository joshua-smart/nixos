{
  user,
  config,
  ...
}:
{
  imports = [
    ./shell.nix
    ./desktop-apps.nix
    ./display
  ];

  # Nixos related options
  home.stateVersion = "23.11";

  # Home manager setup
  programs.home-manager.enable = true;
  home.username = user;
  home.homeDirectory = "/home/${user}";
  xdg.userDirs.pictures = "${config.home.homeDirectory}/Images";

  # Services
  services.syncthing.enable = true;
  programs.git.ignores = [ ".stfolder/" ];
  services.udiskie = {
    enable = true;
    tray = "auto";
  };
}
