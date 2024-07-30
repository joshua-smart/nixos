{ pkgs, config, lib, ... }: with lib;
{

  config = mkIf config.programs.vscode.enable {

    programs.vscode = {
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [ ];
    };
  };
}
