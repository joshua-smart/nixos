{ pkgs, ... }: {
  programs.firefox = {
    enable = true;

    profiles = {
      main = {
        name = "main";
        search.engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [{
                name = "query";
                value = "{searchTerms}";
              }];
            }];
            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@pkgs" ];
          };
          "NixOS Wiki" = {
            urls = [{
              template = "https://wiki.nixos.org/w/index.php";
              params = [{
                name = "search";
                value = "{searchTerms}";
              }];
            }];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@nixos" ];
          };
        };
      };
    };
  };

  home.sessionVariables = { MOZ_USE_XINPUT2 = "1"; };
}
