{ ... }:
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;

    nix-direnv.enable = true;

    stdlib = ''
      export DIRENV_ACTIVE=1
    '';
  };

  # Replace with programs.direnv.silent = true; when option is stabilised
  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };
}
