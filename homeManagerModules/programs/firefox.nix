{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf config.programs.firefox.enable {
    programs.firefox = {
      profiles = {
        main = {
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

              #context-navigation,
              #context-sep-navigation {
                display:none !important;
              }

              #back-button,
              #forward-button {
                display: none !important;
              }
            '';
          extraConfig = # js
            ''
              user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
            '';
        };
      };
    };

    home.sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
    };
  };
}
