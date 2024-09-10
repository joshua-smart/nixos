{
  config,
  lib,
  pkgs,
  chaotic,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

in
{
  options.programs.godot.enable = mkEnableOption "godot";

  config = mkIf config.programs.godot.enable {
    home.packages =
      [ chaotic.packages.x86_64-linux.godot_4-mono ]
      ++ (with pkgs; [
        omnisharp-roslyn
        dotnetCorePackages.sdk_8_0
      ]);
  };
}
