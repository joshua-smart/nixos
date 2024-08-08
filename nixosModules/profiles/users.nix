{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.profiles.users.enable = mkEnableOption "users profile";

  config = mkIf config.profiles.users.enable {
    users.defaultUserShell = pkgs.zsh;

    users.users.js = {
      uid = 1000;
      isNormalUser = true;
      description = "Joshua Smart";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "docker"
        "uinput"
      ];
      useDefaultShell = true;
    };
  };
}
