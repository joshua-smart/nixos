{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.zsh;

  users.users.js = {
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
}
