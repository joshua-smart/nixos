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

  config = mkIf config.programs.helix.enable {
    programs.helix = {
      package = pkgs.unstable.helix;

      settings = {
        theme = "monokai_pro";
        editor = {
          completion-trigger-len = 1;
          completion-replace = true;
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
