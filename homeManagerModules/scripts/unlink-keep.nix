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

  cp $file $tmpdir
  rm $file
  cp $tmpdir/$file .
  rm -f $tmpdir/$file

  # ensure file has write permissions
  chmod +w $file
''
