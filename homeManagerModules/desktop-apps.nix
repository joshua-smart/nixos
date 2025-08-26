{
  lib,
  pkgs,
  ...
}:
{
  programs.alacritty =
    let
      inherit (lib) recursiveUpdate;
      theme =
        name:
        fromTOML (
          builtins.readFile (
            pkgs.fetchFromGitHub {
              owner = "alacritty";
              repo = "alacritty-theme";
              rev = "a4041ae";
              sha256 = "sha256-A5Xlu6kqB04pbBWMi2eL+pp6dYi4MzgZdNVKztkJhcg=";
            }
            + "/themes/${name}.toml"
          )
        );
    in
    {
      enable = true;
      settings = {
        font.size = 12;
        font.normal.family = "FiraCodeNerdFontPropo";
        window = {
          padding = {
            x = 4;
            y = 4;
          };
          opacity = 0.6;
          title = "Terminal";
        };
        env.TERM = "xterm-256color";
      } // recursiveUpdate (theme "doom_one") { colors.primary.foreground = "#eeeeee"; };
    };

  programs.firefox = {
    enable = true;
    profiles.main = {
      name = "main";
      search = {
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [
              "@nixpkgs"
              "@np"
            ];
          };
          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [
              "@nixopts"
              "@no"
            ];
          };
          "Home Manager Options" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [
              "@home-manager-opts"
              "@hm"
            ];
          };
          "5e.tools" = {
            urls = [
              {
                template = "https://5e.tools/search.html";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "https://5e.tools/favicon.svg";
            definedAliases = [
              "@5e.tools"
              "@5e"
            ];
          };
        };
      };
      userChrome = # css
        ''
          @namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul"); /* only needed once */
          #context-navigation, #context-sep-navigation {
            display:none !important;
          }
          #back-button, #forward-button {
            display: none !important;
          }
        '';
      extraConfig = # js
        ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        '';
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  home.packages = with pkgs; [
    thunderbird
    discord
    obsidian
    slack
    zulip
    spotify
  ];
}
