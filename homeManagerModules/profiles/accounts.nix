{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  pass = "${pkgs.pass}/bin/pass";
in
{

  options.profiles.accounts.enable = mkEnableOption "accounts profile";

  config = mkIf config.profiles.accounts.enable {
    accounts.email.accounts.personal = {
      primary = true;
      address = "josh@thesmarts.co.uk";
      thunderbird = mkIf config.programs.thunderbird.enable {
        enable = true;
        profiles = [ "personal" ];
      };
      realName = "Joshua Smart";
      userName = "josh@thesmarts.co.uk";
      passwordCommand = "${pass} mail.controldns.co.uk/josh@thesmarts.co.uk";

      imap = {
        host = "mail.controldns.co.uk";
        port = 993;
      };

      smtp = {
        host = "mail.controldns.co.uk";
        port = 465;
      };
    };
  };
}
