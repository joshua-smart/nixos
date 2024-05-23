{ pkgs, pkgs-unstable, ... }: {
  imports = [
    ./firefox.nix
    ./alacritty.nix
    ./bash.nix
    ./git.nix
    ./helix.nix
    ./password-store.nix
    ./gnupg.nix
    ./gitui.nix
    ./wofi.nix
  ];

  home.packages = (with pkgs; [ discord tree spotify prismlauncher ])
    ++ (with pkgs-unstable; [ nh obsidian ]);
}
