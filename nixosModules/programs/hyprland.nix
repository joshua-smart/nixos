{
  config,
  lib,
  pkgs,
  home-manager,
  ...
}:
let
  inherit (lib)
    mkIf
    mkOption
    types
    attrsets
    strings
    ;
  inherit (home-manager.lib.hm.generators) toHyprconf;

  cfg = config.programs.hyprland;

  sessionOptions = {
    options = {
      monitors = mkOption { type = types.listOf types.str; };
      workspaces = mkOption { type = types.attrsOf (types.listOf types.int); };
    };
  };

  generateSessionSettings =
    name: session:
    pkgs.writeText "hyprland-${name}-conf" (toHyprconf {
      attrs = {
        source = "/home/js/.config/hypr/hyprland.conf";
        monitor = session.monitors;
        workspace =
          let
            toLine = (
              monitor: workspace:
              let
                ws = toString workspace;
              in
              "${ws},monitor:${monitor}"
            );
            lists = builtins.attrValues (
              builtins.mapAttrs (monitor: workspaces: map (ws: toLine monitor ws) workspaces) session.workspaces
            );
          in
          builtins.concatLists lists;
      };
    });

  sessionsPackage = pkgs.stdenv.mkDerivation {
    name = "hyprland-sessions";
    dontUnpack = true;

    installPhase = strings.concatLines (
      [ "mkdir -p $out/share/wayland-sessions" ]
      ++ attrsets.mapAttrsToList (
        name: session:
        let
          hyprland = "${pkgs.hyprland}/bin/hyprland";
          desktopItem = pkgs.makeDesktopItem {
            name = "hyprland-${name}";
            desktopName = "Hyprland-${name}";
            exec = "${hyprland} --config ${generateSessionSettings name session}";
          };
        in
        "cp ${desktopItem}/share/applications/* $out/share/wayland-sessions"
      ) cfg.sessions
    );

    passthru.providedSessions = map (n: "hyprland-${n}") (builtins.attrNames cfg.sessions);
  };
in
{
  options.programs.hyprland = {
    sessions = mkOption { type = types.attrsOf (types.submodule sessionOptions); };
  };

  config = mkIf config.programs.hyprland.enable {
    programs.hyprland.xwayland.enable = true;

    services.displayManager.sessionPackages = [ sessionsPackage ];
  };
}
