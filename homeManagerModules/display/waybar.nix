{ ... }: {
  home.file.".config/waybar/config.jsonc".text = ''
    {
      "height": 30,
      "spacing": 4,
      
      "modules-left": [
        "hyprland/workspaces"
      ],
      "modules-center": [
        "clock"
      ],
      "modules-right": [
        "cpu",
        "memory",
        "backlight",
        "battery",
        "network",
        "tray"
      ],

      "hyprland/workspaces": {
        "persistent-workspaces": { "*": 5 }
      }
    }
  '';

  home.file.".config/waybar/style.css".source = ./waybar-style.css;
}
