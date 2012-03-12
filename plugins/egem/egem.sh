#!/bin/sh

if [[ -z "$EDITOR" ]]; then
  echo_error "Define the EDITOR environment variable in your '~/.bashrc' file to use the 'egem' plugin."
  return 1
fi

usage() {
  echo "Usage: $(basename $0) <gem>" 1>&2
  exit 1
}

GEM="$1"

[ -z "$GEM" ] && usage
$EDITOR "$(gem environment gemdir)/gems/$GEM"
