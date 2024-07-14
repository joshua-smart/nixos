{ pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
    iconTheme = {
      name = "Monday";
      package = import ./monday-icon-theme.nix pkgs;
    };
  };
}
