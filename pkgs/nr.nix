{ writeShellScriptBin, ... }:
writeShellScriptBin "nr" ''
  nix run nixpkgs#$1 -- "''${@:2}"
''
