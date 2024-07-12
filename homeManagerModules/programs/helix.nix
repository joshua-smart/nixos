{ pkgs, ... }:
{
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
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
        }
      ];
    };

    defaultEditor = true;
    extraPackages = with pkgs; [
      nixfmt
      nil
    ];
  };
}
