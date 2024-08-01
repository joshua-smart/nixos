{ config, lib, ... }:
with lib;
let
  session = {
    foreground = "green";
    foreground_templates = [
      "{{ if eq \"laptop\" .HostName }}green{{end}}"
      "{{ if eq \"server\" .HostName }}red{{end}}"
      "{{ if eq \"desktop\" .HostName }}lightBlue{{end}}"
    ];
    template = "{{ .UserName }}@{{ .HostName }}";
    type = "session";
  };
  path = {
    foreground = "blue";
    properties = {
      style = "folder";
    };
    template = "{{ .Path }} ";
    type = "path";
  };
  git = {
    foreground = "yellow";
    properties = {
      branch_icon = "";
      fetch_stash_count = true;
      fetch_status = false;
      fetch_upstream_icon = true;
    };
    template = "󰊢 {{ .HEAD }}";
    type = "git";
  };
  sym = {
    type = "text";
    foreground = "magenta";
    template = "$";
  };
  colon = {
    type = "text";
    foreground = "white";
    template = ":";
  };
  nix = {
    type = "text";
    foreground = "cyan";
    template = "{{ if .Env.IN_NIX_SHELL }}  {{ end }}";
  };
  direnv = {
    type = "text";
    foreground = "red";
    template = "{{ if .Env.DIRENV_ACTIVE }}󱁿  {{ end }}";
  };
in
{

  config = mkIf config.programs.oh-my-posh.enable {

    programs.oh-my-posh = {
      enableZshIntegration = true;

      settings = {

        console_title_template = "{{ .PWD }} - Terminal";
        blocks = [
          {
            alignment = "left";
            segments = [
              session
              colon
              path
              sym
            ];
            type = "prompt";
          }
          {
            alignment = "left";
            segments = [
              direnv
              nix
              git
            ];
            type = "rprompt";
          }
        ];
        final_space = true;
        version = 2;
      };
    };
  };
}
