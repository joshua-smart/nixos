{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;

  nr = pkgs.writeShellScriptBin "nr" ''
    nix run nixpkgs#$1 -- "''${@:2}"
  '';
in
{
  options.profiles.shell.enable = mkEnableOption "shell profile";

  config = mkIf config.profiles.shell.enable {

    programs = {
      zsh.enable = true;
      oh-my-posh.enable = true;
      git.enable = true;
      gitui.enable = true;
      tmux.enable = true;
      helix.enable = true;
      direnv.enable = true;
      ssh.enable = true;
      zoxide.enable = true;
    };

    home.packages =
      [ nr ]
      ++ (with pkgs; [
        nh
        tree
        zip
        unzip
      ]);
  };
}
