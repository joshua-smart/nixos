{ inputs, self, ... }:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./hardware-configuration.nix
      inputs.agenix.nixosModules.default
    ]
    ++ (with self.nixosModules; [
      base
      laptop
    ]);
    specialArgs = {
      host = "laptop";
    };
  };

  flake.homeConfigurations."js@laptop" = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [
      inputs.agenix.homeModules.default
      inputs.nix-index-database.homeModules.default
    ]
    ++ (with self.homeModules; [
      base
      "js@laptop"
    ]);
  };

  flake.nixosModules.laptop =
    {
      pkgs,
      config,
      ...
    }:
    {
      networking.firewall.allowedTCPPorts = [
        3000
        8080
      ];

      nix.flake = "/home/js/Projects/nixos";

      programs = {
        steam.enable = true;
        wireshark.enable = true;
      };

      users.users.js.extraGroups = [ "wireshark" ];

      virtualisation.virtualbox.host.enable = true;
      users.extraGroups.vboxusers.members = [ "js" ];
      boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

      environment.systemPackages = with pkgs; [
        displaylink
      ];
      services.xserver.videoDrivers = [
        "displaylink"
        "modesetting"
      ];
      boot = {
        extraModulePackages = [ config.boot.kernelPackages.evdi ];
        initrd = {
          # List of modules that are always loaded by the initrd.
          kernelModules = [
            "evdi"
          ];
        };
      };

      services = {
        printing.enable = true;
        udisks2.enable = true;
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
        tailscale = {
          enable = true;
          useRoutingFeatures = "client";
        };
      };

      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      services.blueman.enable = true;

      powerManagement.enable = true;
      services.thermald.enable = true;
      services.tlp.enable = true;

      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
      nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;

      services.kanata = {
        enable = true;
        keyboards."default" = {
          devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
          port = 8080;
          config = ''
            (deflocalkeys-linux
              tpad 530
              cam 212
            )
            (defsrc
                   mute vold volu
              esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12  prtsc   del
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc    home
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    bksl    pgup
              caps a    s    d    f    g    h    j    k    l    ;    '    ret          pgdn
              lsft nubs z    x    c    v    b    n    m    ,    .    /    rsft     up  end
              lctl lmet lalt                spc            ralt comp rctl    left down right
            )
            (deflayer default
                   f1   f2   f3
              esc  mute vold volu brdn brup tpad f7   f8   f9   cam  f11  f12  prtsc   del
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc    home
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    bksl    pgup
              esc  a    s    d    f    g    h    j    k    l    ;    '    ret          pgdn
              lsft nubs z    x    c    v    b    n    m    ,    .    /    rsft     up  end
              lctl lmet lalt                spc            ralt comp rctl    left down right
            )
          '';
        };
        keyboards."brightness" = {
          devices = [ "/dev/input/brightness-control" ];
          config = ''
            (defsrc
              brdn brup
            )
            (deflayer default
              f4 f5
            )
          '';
        };
        keyboards."misc" = {
          devices = [ "/dev/input/by-path/platform-asus-nb-wmi-event" ];
          config = ''
            (deflocalkeys-linux
              tpad 530
              cam 212
            )
            (defsrc
              tpad cam
            )
            (deflayer default
              f6 f10
            )
          '';
        };
      };
      services.udev.extraRules = ''
        SUBSYSTEMS=="input", ATTRS{name}=="Video Bus", SYMLINK+="input/brightness-control"
      '';
    };

  flake.homeModules."js@laptop" =
    { pkgs, ... }:
    {
      services = {
        udiskie.enable = true;
        # Bluetooth media control
        mpris-proxy.enable = true;
        syncthing.enable = true;
        blueman-applet.enable = true;
        trayscale.enable = true;
      };

      home.packages =
        (with pkgs; [
          inkscape
          gimp
          # gramps
          prismlauncher
          freecad
        ])
        ++ [
          self.packages.magicq
        ];

      wayland.windowManager.hyprland.keybinds.volume-step = 5;

      programs.waybar = {
        monitors = [ "eDP-1" ];
        workspaces = [
          1
          2
        ];
        modules = "disk,cpu,memory,backlight,battery,pulseaudio,network,tray";
      };
    };
}
