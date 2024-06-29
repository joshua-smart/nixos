{ pkgs, ... }: {
  imports = [
    ./firefox.nix
    ./alacritty.nix
    ./bash.nix
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
  ];

  home.packages = with pkgs; [ nh obsidian tree spotify prismlauncher lutris ];
}
