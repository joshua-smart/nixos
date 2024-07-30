{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
{

  config = mkIf config.programs.helix.enable {
    programs.helix = {

      settings = {
        theme = "monokai_pro";
        editor = {
          bufferline = "always";
          soft-wrap.enable = true;
        };
      };

      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "nixfmt";
            };
          }
        ];
      };

      defaultEditor = true;
      extraPackages = with pkgs; [
        nixfmt-rfc-style
        nil
      ];
    };
  };
}
