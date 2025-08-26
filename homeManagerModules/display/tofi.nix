{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;

  ssh = pkgs.writeShellScriptBin "tofi-ssh" ''
    cat ${config.home.homeDirectory}/.ssh/known_hosts \
    | awk '{print $1}' \
    | uniq \
    | ${pkgs.tofi}/bin/tofi \
      --prompt-text "ssh " \
      --history-file ${config.xdg.stateHome}/tofi-ssh-history
  '';
  drun = pkgs.writeShellScriptBin "tofi-drun" ''
    ${pkgs.tofi}/bin/tofi-drun \
      --prompt-text "run "
  '';
in
{
  options.programs.tofi.scripts = {
    ssh = mkOption {
      type = types.path;
      description = ''
        Path to ssh launcher script.
      '';
    };
    drun = mkOption {
      type = types.path;
      description = ''
        Path to drun launcher script.
      '';
    };
  };

  config = {
    programs.tofi = {
      enable = true;

      scripts = {
        ssh = "${ssh}/bin/tofi-ssh";
        drun = "${drun}/bin/tofi-drun";
      };

      settings = {
        fuzzy-match = true;

        # positioning
        anchor = "top";
        width = "100%";
        height = 32;
        exclusive-zone = 0;

        text-cursor = true;
        text-cursor-style = "block";

        font = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts/FiraCode/FiraCodeNerdFontPropo-Regular.ttf";

        horizontal = true;
        font-size = 11;
        outline-width = 0;
        border-width = 0;

        background-color = "#222222AA";
        text-color = "#cccccc";

        prompt-color = "#ffffff";
        selection-color = "#ffffff";

        min-input-width = 120;
        result-spacing = 15;

        # padding
        padding-top = 7;
        padding-bottom = 4;
        padding-left = 4;
        padding-right = 4;
      };
    };

    home.activation.flushTofiCache =
      lib.hm.dag.entryAfter [ "writeBoundary" ] # bash
        ''
          cache=${config.home.homeDirectory}/.cache/tofi-drun
          [ -e $cache ] && rm $cache
        '';
  };
}
