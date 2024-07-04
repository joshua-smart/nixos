{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    ./alacritty.nix
    ./git.nix
    ./helix.nix
    ./password-store.nix
    ./gnupg.nix
    ./gitui.nix
    ./thunderbird.nix
    ./discord.nix
    ./feh.nix
    ./oh-my-posh.nix
    ./vscode.nix
    ./tmux.nix
    ./direnv.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    nh
    obsidian
    tree
    spotify
    prismlauncher
    lutris
  ];
}
