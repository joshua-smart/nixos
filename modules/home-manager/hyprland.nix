{ pkgs, ... }: {
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "${pkgs.alacritty}/bin/alacritty";
    bind = [
      "$mod, RETURN, exec, $terminal"
      "$mod, T, exec, ${pkgs.alacritty}/bin/alacritty"
    ];
  };
}
