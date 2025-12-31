# pyenv plugin with lazy loading
# Set PYENV_LAZY=0 in your .bashrc before sourcing bash.env to disable lazy loading

# Check for pyenv in common locations
if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  pathmunge "$PYENV_ROOT/bin" before
elif command -v brew &>/dev/null; then
  _brew_prefix="$(brew --prefix)"
  if [[ -d "$_brew_prefix/opt/pyenv" ]]; then
    export PYENV_ROOT="$_brew_prefix/opt/pyenv"
  fi
  unset _brew_prefix
fi

# Check if pyenv is available
if [[ -z "$PYENV_ROOT" ]] || ! command -v pyenv &>/dev/null; then
  echo "WARNING: You have enabled the pyenv plugin but pyenv is not installed."
  echo "Install via: brew install pyenv"
  echo "   or: git clone https://github.com/pyenv/pyenv.git ~/.pyenv"
  return 0
fi

# Lazy loading (default) or immediate loading
if [[ "${PYENV_LAZY:-1}" == "1" ]]; then
  # Commands that should trigger pyenv loading
  _pyenv_lazy_cmds=(pyenv python python3 pip pip3 python2 pip2 pydoc)

  _pyenv_load() {
    # Remove lazy loading functions
    for cmd in "${_pyenv_lazy_cmds[@]}"; do
      unset -f "$cmd" 2>/dev/null
    done
    unset -f _pyenv_load
    unset _pyenv_lazy_cmds

    # Initialize pyenv
    eval "$(pyenv init -)"

    # Load pyenv-virtualenv if installed
    if command -v pyenv-virtualenv-init &>/dev/null; then
      eval "$(pyenv virtualenv-init -)"
    fi
  }

  # Create lazy loading wrapper for each command
  for cmd in "${_pyenv_lazy_cmds[@]}"; do
    eval "
      $cmd() {
        _pyenv_load
        $cmd \"\$@\"
      }
    "
  done
else
  # Immediate loading
  eval "$(pyenv init -)"
  if command -v pyenv-virtualenv-init &>/dev/null; then
    eval "$(pyenv virtualenv-init -)"
  fi
fi
