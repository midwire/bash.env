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

function load_on_login {
  profile_file="$HOME/.bashrc"
  if [[ -f "${profile_file}" ]] &&
    ! grep '. $HOME/.env/bash.env.sh' "$profile_file" >/dev/null 2>&1
  then
    echo '[[ -r $HOME/.env/bash.env.sh ]] && . $HOME/.env/bash.env.sh' >> "$profile_file"
    echo ".env will now load on login."
  else
    echo ".env is already setup to load on login."
  fi
  return 0
}

function load_on_alias {
  if [[ -z $1 ]]; then
    als="bashenv"
  else
    als="$1"
  fi
  profile_file="$HOME/.bashrc"
  if [[ -f "${profile_file}" ]] &&
    ! grep "alias $als=\". $HOME/.env/bash.env.sh\"" "$profile_file" >/dev/null 2>&1
  then
    echo "alias $als=\". $HOME/.env/bash.env.sh\"" >> "$profile_file"
    echo ".env will now load when you execute '$als'."
  else
    echo ".env is already setup to load on using the '$als' alias."
  fi
  return 0
}

bigfind() {
  if [[ $# -lt 1 ]]; then
    echo_warn "Usage: bigfind DIRECTORY"
    return
  fi
  sudo find ${1} -size +10M | xargs sudo du -h | sort -nr
  # du -a ${1} | sort -n -r | head -n 10
}

# show the n most used commands. defaults to 10
history_stats() {
  if [[ $# -lt 1 ]]; then
    NUM=10
  else
    NUM=$1
  fi
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head -$NUM
}

gdir() {
  mkdir ${1}
  cd ${1}
}

upgrade.bash.env() {
  $dot_env_path/bin/upgrade.env
}

# Add your public SSH key to a remote host
add_ssh_key_to_host() {
  local keypath
  if [[ $# -lt 1 ]]; then
    echo_warn "Usage: add_ssh_key_to_host [user@]HOSTNAME"
    return
  fi
  if [[ $# -eq 2 ]] && [[ ! -r "${2}" ]]; then
      echo "Key cannot be read: ${2}"
      exit 1
  elif [[ -r "${2}" ]]; then
    keypath="${2}"
  elif [[ -r "$HOME/.ssh/id_rsa.pub" ]]; then
    keypath="$HOME/.ssh/id_rsa.pub"
  elif [[ -r "$HOME/.ssh/id_dsa.pub" ]]; then
    keypath="$HOME/.ssh/id_dsa.pub"
  else
    echo "You need to generate a key first: 'ssh-keygen -b 4048 -t rsa'"
    exit 1
  fi
  if ! command ssh-keygen -l -f "${keypath}" 1> /dev/null
  then
      # use error message from command
      exit 1
  fi

  cat "${keypath}" | ssh $1 "mkdir -p ~/.ssh; cat >> .ssh/authorized_keys"
}

# Propagate your bash.env configurations to a remote host
propagate_env_to_host() {
  if [[ $# -lt 1 ]]; then
    echo_warn "Usage: propagate_env_to_host [user@]HOSTNAME"
    return
  fi

  host=$1
  shift 1
  ENVFILE=$HOME/env.tar.gz
  local saved_pwd
  saved_pwd=$(pwd)
  cd "$HOME" || return
  echo_info "Compressing local environment..."
  COPYFILE_DISABLE=1 tar chfvz $ENVFILE --exclude='.DS_Store' --exclude='.env/plugins/elocate/elocatedb' .env/ &> /dev/null
  echo_info "Copying environment to $host..."
  scp $ENVFILE $host:
  if [[ $? != 0 ]]; then echo "Copy failed!"; return; fi
  echo_info "Installing environment on $host..."
  ssh $host "rm -rf ~/.env/ && gunzip < env.tar.gz |tar xfv -" &> /dev/null
  echo_warn "Don't forget to add this your .bashrc file:"
  echo_warn 'if [[ -n "$PS1" ]]; then'
  echo_warn '  [[ -r $HOME/.env/bash.env.sh ]] && . $HOME/.env/bash.env.sh'
  echo_warn 'fi'
  cd "$saved_pwd" || return
}

# Configure environment settings for your local machine.
configthis.env() {
  DIR="$dot_env_path/host/$HOSTNAME"
  mkdir -p "$DIR"
  touch "$DIR/env.sh"
  touch "$DIR/functions.sh"
  if [[ ! -f "$DIR/alias.sh" ]]; then
    echo "# Add your specific aliases here:\n# Example: alias home='cd \$HOME' " >> "$DIR/alias.sh"
  fi
  if [[ ! -f "$DIR/path.sh" ]]; then
    echo "# Add paths like this:\n# pathmunge \"/Developer/usr/bin\"" >> "$DIR/path.sh"
  fi
  echo_info "Edit files in [$DIR] to customize your local environment."
  ls -1AtF "$DIR"
}

# Configure environment settings for a specified HOSTNAME
confighost.env() {
  if [[ $# -lt 1 ]]; then
    echo_warn "Usage: confighost.env HOSTNAME"
    return
  fi
  host=$1
  shift 1
  DIR="$dot_env_path/host/$host"
  mkdir -p "$DIR"
  touch "$DIR/env.sh"
  touch "$DIR/functions.sh"
  if [[ ! -f "$DIR/alias.sh" ]]; then
    echo "# Add your host specific aliases here:\n# Example: alias home='cd \$HOME' " >> "$DIR/alias.sh"
  fi
  if [[ ! -f "$DIR/path.sh" ]]; then
    echo "# Add paths like this:\n# pathmunge \"/Developer/usr/bin\"" >> "$DIR/path.sh"
  fi
  echo_info "Edit these files to customize your [$host] environment."
  echo_info "When you are finished run 'propagate_env_to_host $host'."
  ls -1AtF "$DIR"
}

reset_theme() {
  export theme="$ORIGINAL_THEME"
  . $dot_env_path/themes/load_theme.sh
}

try_theme() {
  if [[ $# -lt 1 ]]; then
    echo_warn "Usage: try_theme THEME_NAME"
    return
  fi
  echo_info "Loading theme [$1]"
  export ORIGINAL_THEME="$theme"
  export theme="$1"
  . $dot_env_path/themes/load_theme.sh
}
