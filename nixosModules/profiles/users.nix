{ config, lib, ... }:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
in
{
  options.profiles.users = {
    enable = mkEnableOption "users profile";
    rootHashedPasswordFile = mkOption {
      type = types.nullOr types.path;
      default = null;
    };
  };

  config = mkIf config.profiles.users.enable {
    age.secrets."js-hashed-password".file = ../../secrets/js-hashed-password.age;

    users.mutableUsers = false;

    users.users.js = {
      uid = 1000;
      hashedPasswordFile = config.age.secrets."js-hashed-password".path;
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

    users.users."root".hashedPasswordFile = mkIf (
      config.profiles.users.rootHashedPasswordFile != null
    ) config.profiles.users.rootHashedPasswordFile;
  };
}
