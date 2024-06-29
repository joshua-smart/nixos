{ ... }:
let
  session = {
    foreground = "green";
    template = "{{ .UserName }}@{{ .HostName }}";
    type = "session";
  };
  path = {
    foreground = "cyan";
    properties = { style = "folder"; };
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
    template = " ({{ .HEAD }})";
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
in {
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;

    settings = {

      console_title_template = "{{ .PWD }} - Terminal";
      blocks = [
        {
          alignment = "left";
          segments = [ session colon path sym ];
          type = "prompt";
        }
        {
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
