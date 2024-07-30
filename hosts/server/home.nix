{ ... }:
{
  imports = [ ../../homeManagerModules ];

  profiles.shell.enable = true;

  programs.helix.settings.editor.true-color = true;
}
