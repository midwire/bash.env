#!/bin/bash
# Usage:
#   dot-files <action> <args>
THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_DIR="${HOME}/.config/dot-files"
CONFIG_FILE="${CONFIG_DIR}/files"
source "$dot_env_path/global/global_colors.sh"
source "$dot_env_path/global/global_functions.sh"

if [[ $# -lt 1 ]]; then
  echo_warn ">>> Usage : dot-files <ACTION> [ARGS]"
  exit
fi

cmd="$1"
shift 1
args="$*"

function ensure_config {
  [[ -d $CONFIG_DIR ]] || mkdir -p $CONFIG_DIR
}

function ensure_config_file {
  ensure_config
  [[ -r $CONFIG_FILE ]] || touch $CONFIG_FILE
}

function check_file {
  file=`grep "$1" "$CONFIG_FILE"`
  return $file
}

function list_files {
  if [[ ! -r "$CONFIG_FILE" ]]; then
    echo_warn ">>> You don't have any files configured yet.  You should add some."
    exit
  fi
  while read str; do
    echo $str
  done < "$CONFIG_FILE"
}

function add_file {
  ensure_config_file
  local ofile="$1"
  local relative=${ofile#$HOME/}
  if [[ `grep "$relative" "$CONFIG_FILE"` ]]; then
    echo_warn ">>> '$1' is already in the repository."
    return 1
  else
    echo "$relative" >> "$CONFIG_FILE"
    return 0
  fi
}

case "$cmd" in

list)  ensure_config
    echo_info ">>> Listing dot-files"
    list_files
    ;;

add)  ensure_config
    if [[ $# -lt 1 ]]; then
      echo_warn ">>> You must specify the file to add"
      echo_warn ">>> : dot-files add <FILEPATH>"
      exit
    fi
    new_file=$1
    shift 1
    echo_info ">>> Adding $new_file to dot-files"
    add_file "$new_file"
    ;;

setup)  ensure_config
    echo_info ">>> Configuring dot-files"
    cd "$HOME"
    files=`ls -d1 .*|grep -v '^.$'|grep -v '^..$'`
    for f in $files; do
      if ask "Would you like to add '$f'?"; then
        add_file "$f"
      fi
    done
    ;;

help) echo ""
    if [ -z "$1" ]; then
        show_help
    else
        $THISDIR/pinkbox_help.sh "$*"
    fi
    ;;

*) echo_error ">>> That command is not in my vocabulary."
    ;;
esac
