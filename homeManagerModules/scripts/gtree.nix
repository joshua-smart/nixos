{ pkgs }:
pkgs.writeShellScriptBin "gtree" ''
  ${pkgs.ripgrep}/bin/rg --files | ${pkgs.tree}/bin/tree --fromfile
''

