{ pkgs, ... }:
let pass = "${pkgs.password-store}/bin/pass";
in {
  accounts.email.accounts.personal = {
    primary = true;
    address = "josh@thesmarts.co.uk";
    thunderbird = {
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
}
