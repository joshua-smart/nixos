{ ... }:
{
  flake.nixosModules.base =
    { pkgs, ... }:
    {
      programs.light.enable = true;
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      };
      services.xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];
      };
      services.greetd = {
        enable = true;
        settings.default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet -d --remember --remember-user-session --time";
          user = "greeter";
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
    };

  flake.homeModules.base =
    { ... }:
    {

    };
}
