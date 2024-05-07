{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "monokai_pro";
      editor = {
        bufferline = "always";
        soft-wrap.enable = true;
      };
    };
    languages = {
      language-server = { nil = { command = "${pkgs.nil}/bin/nil"; }; };
      language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
      }];
    };
  };
}
