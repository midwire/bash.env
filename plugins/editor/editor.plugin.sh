# Try to find an editor if one has not be defined.
editors="subl vim vi atom mate jedit redcar emacs nano pico jed"
for e in $editors; do
  [[ -z "$EDITOR" ]] && [[ -x `which $e` ]] && export EDITOR=`which $e`
  [[ -n "$EDITOR" ]] && break
done

if [[ -z "$EDITOR" ]]; then
  echo_error "Define the EDITOR environment variable in your '~/.bashrc' file to use the editing aliases for OSX."
  return 1
fi

# Common editor environment vars
export CVSEDITOR="$EDITOR"
export SVN_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

# Frequent editing command aliases
alias edit="$EDITOR"

# Load the current directory into your editor
alias e="$EDITOR ."

# Edit/Source local host aliases.
alias ea="$EDITOR $dot_env_path/host/$HOSTNAME/alias.sh"
alias eas="source $dot_env_path/host/$HOSTNAME/alias.sh"

# Edit your local $HOME/bin scripts
alias eb="$EDITOR $HOME/bin"

# Edit/Source all of .env
alias ee="$EDITOR $dot_env_path $HOME/.bashrc"
alias ees="source $dot_env_path/bash.env.sh"

# Edit/Source local host functions
alias ef="$EDITOR $dot_env_path/host/$HOSTNAME/functions.sh"
alias efs="source $dot_env_path/host/$HOSTNAME/functions.sh"

# Edit your ssh config
alias eh="$EDITOR $HOME/.ssh/config"

# Edit/Source path customizations
alias ep="$EDITOR $dot_env_path/host/$HOSTNAME/path.sh"
alias eps="source $dot_env_path/host/$HOSTNAME/path.sh"

# Edit/Source current host customizations
alias ehost="$EDITOR $dot_env_path/host/$HOSTNAME"
alias ehosts="source $dot_env_path/host/$HOSTNAME"
