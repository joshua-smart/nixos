{ ... }: {
  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      blocks = [
        {
          alignment = "left";
          segments = [
            {
              background = "#6272a4";
              foreground = "#f8f8f2";
              leading_diamond = "";
              style = "diamond";
              template = "{{ .UserName }}@{{ .HostName }} ";
              type = "session";
            }
            {
              background = "#bd93f9";
              foreground = "#f8f8f2";
              powerline_symbol = "";
              properties = { style = "folder"; };
              style = "powerline";
              template = " {{ .Path }} ";
              type = "path";
            }
            {
              background = "#ffb86c";
              foreground = "#f8f8f2";
              powerline_symbol = "";
              properties = {
                branch_icon = "";
                fetch_stash_count = true;
                fetch_status = false;
                fetch_upstream_icon = true;
              };
              style = "powerline";
              template = "  ({{ .HEAD }}) ";
              type = "git";
            }
          ];
          type = "prompt";
        }
        {
          # redundant
          alignment = "left";
          segments = [{
            background = "#f1fa8c";
            foreground = "#282a36";
            invert_powerline = true;
            leading_diamond = "";
            style = "diamond";
            template = "  {{.Profile}}{{if .Region}}@{{.Region}}{{end}}";
            trailing_diamond = "";
            type = "aws";
          }];
          type = "rprompt";
        }
      ];
      final_space = true;
      version = 2;
    };
  };
}
