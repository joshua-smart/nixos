{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.ssh.enable {
    age.secrets."nix-homelab-admin-ssh-key".file = ../../secrets/nix-homelab-admin-ssh-key.age;

    programs.ssh = {
      matchBlocks = {
        "*.hosts.jsmart.dev" = {
          user = "admin";
          identityFile = config.age.secrets."nix-homelab-admin-ssh-key".path;
        };
        "falen.hosts.jsmart.dev" = {
          port = 3000;
        };
      };
    };
  };
}
