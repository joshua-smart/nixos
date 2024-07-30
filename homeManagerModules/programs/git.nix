{ config, lib, ... }:
with lib;
{
  config = mkIf config.programs.git.enable {
    programs.git = {
      userName = "Joshua Smart";
      userEmail = "josh@thesmarts.co.uk";
    };
  };
}
