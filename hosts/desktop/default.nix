{ inputs, self, ... }:
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./hardware-configuration.nix
      inputs.agenix.nixosModules.default
      self.nixosModules.desktop
      self.nixosModules.common
    ];
    specialArgs = {
      host = "desktop";
    };
  };

  flake.homeConfigurations."js@desktop" = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [
      inputs.agenix.homeModules.default
      inputs.nix-index-database.homeModules.default
      self.homeModules."js@desktop"
    ];
  };

  flake.nixosModules.desktop =
    { config, pkgs, ... }:

    {
      imports = [
        # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ../../configuration-common.nix
      ];

      virtualisation.docker.enable = true;
      virtualisation.virtualbox.host.enable = true;

      networking.firewall.allowedTCPPorts = [
        3000
        8080
      ];

      environment.systemPackages = with pkgs; [
        wireguard-tools
        protonvpn-gui
        wireshark
        openssl.dev
        openssl
      ];

      programs.wireshark.enable = true;
      users.users.js.extraGroups = [ "wireshark" ];

      nix.flake = "/home/js/Projects/nixos";

      programs = {
        steam.enable = true;
      };

      services = {
        printing.enable = true;
        udisks2.enable = true;
        tailscale = {
          enable = true;
          useRoutingFeatures = "client";
        };
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
      };

      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = false;
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
      boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
      nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;

      # Audio crackling fix
      services.pipewire.extraConfig.pipewire."0-cracking-fix" = {
        "default.clock.min-quantum" = 1024;
      };

      # Keymap
      services.kanata = {
        enable = true;
        keyboards."default".config = ''
          (defsrc caps f1 mute)
          (deflayer default esc mute f1)
        '';
      };
    };

  flake.homeModules."js@desktop" =
    { config, pkgs, ... }:
    {
      imports = [ ../../homeManagerModules ];

      programs = {
        password-store.enable = true;
      };

      services = {
        udiskie.enable = true;
        syncthing.enable = true;
        easyeffects = {
          enable = true;
          preset = "denoise";
        };
        trayscale.enable = true;
      };

      wayland.windowManager.hyprland = {
        sessions.default = {
          monitors = [
            "HDMI-A-1,prefered,auto,1"
            "HDMI-A-2,prefered,auto-right,1"
          ];
          workspaces = {
            HDMI-A-1 = [ 1 ];
            HDMI-A-2 = [ 2 ];
          };
        };
        nvidia = true;
        keybinds.volume-step = 1;
      };

      programs.waybar = {
        monitors = [ "HDMI-A-1" ];
        workspaces = [
          1
          2
        ];
        modules = "disk,cpu,memory,pulseaudio,network,tray";
      };

      home.packages = with pkgs; [
        ryubing
        gimp
        inkscape
        antimicrox
        # maptool
        qbittorrent
        prismlauncher
        (pkgs.symlinkJoin {
          name = "freecad";
          paths = [ pkgs.freecad ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/FreeCAD \
              --set QT_QPA_PLATFORM xcb
          '';
        })
        povray
        myPackages.magicq
        kdePackages.kdenlive
      ];
    };
}
