{
  pkgs,
  inputs,
  host,
  user,
  config,
  ...
}:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ".." = "cd ..";
      "ls" = "${pkgs.eza}/bin/eza";
      "la" = "ls -a";
      "ll" = "ls -l";
      "open" = "${pkgs.xdg-utils}/bin/xdg-open";
      "tree" = "ls -T";
    };

    dotDir = ".config/zsh";

    initContent = ''
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      bindkey "^H" backward-kill-word
      bindkey "^[[3;5~" forward-kill-word

      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
  };

  programs.oh-my-posh =
    let
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
      enable = true;
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

  programs.git = {
    enable = true;
    userName = "Joshua Smart";
    userEmail = "josh@thesmarts.co.uk";
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "Space";
    escapeTime = 0;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    terminal = "tmux-256color";
    mouse = true;

    extraConfig = ''
      set -ag terminal-overrides ",$TERM:Tc"
      set -g status-left-length 20
    '';

    tmuxinator.enable = true;
  };

  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;
    settings = {
      theme = "monokai_pro";
      editor = {
        completion-trigger-len = 1;
        bufferline = "always";
        soft-wrap.enable = true;
      };
      keys.insert = {
        up = "no_op";
        down = "no_op";
        left = "no_op";
        right = "no_op";
        pageup = "no_op";
        pagedown = "no_op";
        home = "no_op";
        end = "no_op";
      };
    };
    languages = {
      language-server = {
        nixd = {
          command = "nixd";
          config.nixd =
            let
              flake = "(builtins.getFlake \"${inputs.self}\")";
            in
            {
              nixpkgs.expr = "import ${flake}.input.nixpkgs {}";
              options = {
                nixos.expr = "${flake}.nixosConfigurations.\"${host}\".options";
                home_manager.expr = "${flake}.homeConfigurations.\"${user}@${host}\".options";
              };
            };
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
          language-servers = [ "nixd" ];
        }
      ];
    };
    defaultEditor = true;
    extraPackages = with pkgs; [
      nixfmt-rfc-style
      nixd
    ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    stdlib = ''
      export DIRENV_ACTIVE=1
    '';
    silent = true;
  };

  age.secrets."nix-homelab-admin-ssh-key".file = ../secrets/nix-homelab-admin-ssh-key.age;
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*.hosts.jsmart.dev" = {
        user = "admin";
        identityFile = config.age.secrets."nix-homelab-admin-ssh-key".path;
      };
      "falen.hosts.jsmart.dev" = {
        port = 3000;
      };
    };
  };

  programs.gitui.enable = true;
  home.packages = with pkgs; [
    nh
    tree
    zip
    unzip
    myPackages.nr
  ];
}
