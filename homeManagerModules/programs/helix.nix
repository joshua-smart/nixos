{
  pkgs,
  config,
  lib,
  inputs,
  user,
  host,
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
  };
}
