{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
in
{

  config = mkIf config.programs.vscode.enable {

    programs.vscode = {
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [ ];
    };
  };
}
