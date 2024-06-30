{ pkgs, ... }:
{
  programs.password-store = {
    enable = true;
  };
  home.packages = with pkgs; [ wl-clipboard ];
}
