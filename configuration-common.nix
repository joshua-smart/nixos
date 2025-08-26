{
  pkgs,
  config,
  lib,
  host,
  ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.nix.flake = mkOption {
    type = types.str;
    default = "/etc/nixos";
    description = "Location of this system flake on the host machine";
  };

  config = {
    # NixOS related options
    system.stateVersion = "23.11";
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Boot configuration
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Internationalisation
    services.automatic-timezoned.enable = true;
    i18n = {
      defaultLocale = "en_GB.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
      };
    };
    services.xserver.xkb = {
      layout = "gb";
      variant = "";
    };
    console.keyMap = "uk";

    # Sound
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    # Display
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
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -d --remember --remember-user-session --time";
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

    # Shell
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    # Networking
    networking.hostName = host;
    networking.networkmanager.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false; # Do not wait for network on boot

    # Users
    users.mutableUsers = true;
    users.users.js = {
      uid = 1000;
      isNormalUser = true;
      description = "Joshua Smart";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      useDefaultShell = true;
    };

    # Programs
    programs.steam = {
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;

    # Services
    services.openssh.enable = true;

    # Packages
    environment.systemPackages = with pkgs; [ helix ];

    # Environment
    environment.variables = {
      NH_FLAKE = config.nix.flake;
      EDITOR = "hx";
    };

  };
}
