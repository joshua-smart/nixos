{ ... }:
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;

    nix-direnv.enable = true;

    stdlib = ''
      export DIRENV_ACTIVE=1
    '';
  };

  # Replace with programs.direnv.silent = true; when option is stabilised
  programs.zsh.initExtra = ''
    export DIRENV_LOG_FORMAT=
  '';
}
