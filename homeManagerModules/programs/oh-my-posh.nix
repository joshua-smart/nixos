{ ... }:
let
  session = {
    foreground = "green";
    template = "{{ .UserName }}@{{ .HostName }} ";
    type = "session";
  };
  path = {
    foreground = "cyan";
    properties = { style = "folder"; };
    template = " {{ .Path }} ";
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
    template = " ({{ .HEAD }})";
    type = "git";
  };
  sym = {
    type = "text";
    foreground = "magenta";
    template = "$";
  };
in {
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      blocks = [
        {
          alignment = "left";
          segments = [ session path sym ];
          type = "prompt";
        }
        {
          # redundant
          alignment = "left";
          segments = [ git ];
          type = "rprompt";
        }
      ];
      final_space = true;
      version = 2;
    };
  };
}
