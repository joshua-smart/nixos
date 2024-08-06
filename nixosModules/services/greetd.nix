{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  config = mkIf config.services.greetd.enable (
    let
      tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
      session = "${pkgs.hyprland}/bin/Hyprland";
    in
    {
      services.greetd = {
        settings = {
          default_session = {
            command = "${tuigreet} --remember --remember-user-session --time --cmd ${session}";
            user = "greeter";
          };
        };
      };

      systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal"; # Without this errors will spam on screen
        # Without these bootlogs will spam on screen
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };
    }
  );
}
