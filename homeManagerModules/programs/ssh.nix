{ config, lib, ... }:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.ssh.enable {
    programs.ssh = {
      matchBlocks = {
        "*.hosts.jsmart.dev" = {
          user = "admin";
        };
      };
    };
  };
}
