{ pkgs }:
pkgs.writeShellScriptBin "unlink-keep" ''
  tmpdir=/tmp/unlink-keep
  file=$1

  # ensure file argument is provided
  if [ -z "$1" ]; then
    echo "No file specified"
    exit 1
  fi

  # ensure temp dir exists
  mkdir -p $tmpdir

  cp $1 $tmpdir
  rm $1
  cp $tmpdir/$1 .
  rm -f $tmpdir/$1
''
