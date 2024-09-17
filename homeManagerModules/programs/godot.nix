{
  config,
  lib,
  pkgs,
  chaotic,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;

  terminal = "${pkgs.alacritty}/bin/alacritty";

  godot-hx-open = pkgs.writeShellScriptBin "godot-hx-open" ''
    dir=$1
    file=$2
    session="godot"
    socket="/tmp/tmux-godot.sock"

    # start session if not exists
    if ! tmux -S "$socket" has-session -t "$session" 2>/dev/null; then
      echo "Session '$session' not found, starting"
      # start session
      COLORTERM=truecolor tmux -S "$socket" new -d -c "$dir" -s "$session"
      # send 'hx' to session
      tmux -S "$socket" send-keys -t "$session:1" "hx" Enter

      # delay to ensure editor is started properly
      sleep 0.5
    fi

    # start client if not attached
    if [ -z "$(tmux -S "$socket" list-clients -t "$session")" ]; then
      ${terminal} -e tmux -S "$socket" attach -t "$session"
      sleep 2
    fi

    # return to normal mode
    tmux -S "$socket" send-keys -t "$session:1" Escape
    # send ':open <file>' to session
    tmux -S "$socket" send-keys -t "$session:1" ":open $file" Enter
  '';
in
{
  options.programs.godot.enable = mkEnableOption "godot";

  config = mkIf config.programs.godot.enable {
    home.packages =
      [
        chaotic.packages.x86_64-linux.godot_4-mono
        godot-hx-open
      ]
      ++ (with pkgs; [
        tmux
        omnisharp-roslyn
        dotnetCorePackages.sdk_8_0
      ]);
  };
}
