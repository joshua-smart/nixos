{ config, lib, ... }:
let
  inherit (lib) mkIf;
  session = {
    foreground = "green";
    foreground_templates = [
      "{{ if eq \"laptop\" .HostName }}green{{end}}"
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
  time = {
    type = "executiontime";
    foreground = "darkGray";
    template = "󱎫 {{ .FormattedMs }} ";
    properties = {
      style = "austin";
      threshold = 500;
    };
  };
in
{

  config = mkIf config.programs.oh-my-posh.enable {

    programs.oh-my-posh = {
      enableZshIntegration = true;

      settings = {

        console_title_template = "{{ .PWD }} - Terminal";
        disable_notice = true;
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
              time
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
