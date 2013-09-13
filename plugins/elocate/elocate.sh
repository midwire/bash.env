#!/bin/bash
THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DB="${THISDIR}/elocatedb"

function ask {
  while true; do
    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # Ask the question
    read -p "$1 [$prompt] " REPLY

    # Default?
    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi
    # Check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac
  done
}

if [ ! -r "$DB" ]; then
  echo "The elocate database [$DB] does not exist."
  if ask "Would you like to build it?" Y; then
    $THISDIR/update_locate_db.sh
  fi
fi

if [ -r "$DB" ]; then
  grep "$1" $DB
fi
