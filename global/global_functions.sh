history_stats() {
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

upgrade.env() {
  $dot_env_path/bin/upgrade.env
}

# Add your public SSH key to a remote host
add_ssh_key_to_host() {
  if [[ $# -lt 1 ]]; then
    echo_warn "Usage: add_ssh_key_to_host [user@]HOSTNAME"
    return
  fi
  if [[ -r ~/.ssh/id_dsa.pub ]]; then
    cat ~/.ssh/id_dsa.pub | ssh $1 "mkdir -p ~/.ssh; cat >> .ssh/authorized_keys"
  elif [[ -r ~/.ssh/id_rsa.pub ]]; then
    cat ~/.ssh/id_rsa.pub | ssh $1 "mkdir -p ~/.ssh; cat >> .ssh/authorized_keys"
  fi
}

# Propagate your entire environment system to a remote host
propagate_env_to_host() {
  if [[ $# -lt 1 ]]; then
    echo_warn "Usage: propagate_env_to_host [user@]HOSTNAME"
    return
  fi

  host=$1
  shift 1
  ENVFILE=$HOME/env.tar.gz
  PWD=`pwd`
  cd $HOME
  echo_info "Compressing local environment..."
  tar cfvz $ENVFILE .env/ &> /dev/null
  echo_info "Copying environment to $host..."
  scp $ENVFILE $host:
  if [[ $? != 0 ]]; then echo "Copy failed!"; return; fi
  echo_info "Installing environment on $host..."
  ssh $host "rm -rf ~/.env/ && gunzip < env.tar.gz |tar xfv -" &> /dev/null
  echo_warn "Don't forget to add this your .bashrc file:"
  echo_warn 'if [[ -n "$PS1" ]]; then'
  echo_warn '  [[ -r $HOME/.env/dot-env.sh ]] && . $HOME/.env/dot-env.sh'
  echo_warn 'fi'
  cd $PWD
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
  cd "$DIR"
  echo_info "Edit these files to customize your local environment."
  ls -1AtF
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
  cd "$DIR"
  echo_info "Edit these files to customize your [$host] environment."
  echo_info "When you are finished run 'propagate_env_to_host $host'."
  ls -1AtF
}

reset_theme() {
  theme="$ORIGINAL_THEME"
  . $dot_env_path/themes/load_theme.sh
}

try_theme() {
  export ORIGINAL_THEME="$theme"
  theme="$1"
  . $dot_env_path/global/global_theme.sh
}
