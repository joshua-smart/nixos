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
    ./thunderbird.nix
  ];

  home.packages =
    (with pkgs; [ nh obsidian discord tree spotify prismlauncher lutris ])
    ++ (with pkgs-unstable; [ ]);
}
