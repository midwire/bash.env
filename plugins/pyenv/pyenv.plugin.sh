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

# Store the path to pyenv binary for use in lazy loading
_PYENV_BIN="$(command -v pyenv)"

# Lazy loading (default) or immediate loading
if [[ "${PYENV_LAZY:-1}" == "1" ]]; then

  _pyenv_load() {
    # Initialize pyenv using the binary path (not function)
    eval "$("$_PYENV_BIN" init -)"

    # Load pyenv-virtualenv if installed
    if command -v pyenv-virtualenv-init &>/dev/null; then
      eval "$("$_PYENV_BIN" virtualenv-init -)"
    fi
    unset _PYENV_BIN
  }

  # Wrapper functions - each unsets itself FIRST to prevent recursion
  pyenv() {
    unset -f pyenv python python3 pip pip3 python2 pip2 pydoc 2>/dev/null
    _pyenv_load
    unset -f _pyenv_load
    pyenv "$@"
  }

  python() {
    unset -f pyenv python python3 pip pip3 python2 pip2 pydoc 2>/dev/null
    _pyenv_load
    unset -f _pyenv_load
    python "$@"
  }

  python3() {
    unset -f pyenv python python3 pip pip3 python2 pip2 pydoc 2>/dev/null
    _pyenv_load
    unset -f _pyenv_load
    python3 "$@"
  }

  pip() {
    unset -f pyenv python python3 pip pip3 python2 pip2 pydoc 2>/dev/null
    _pyenv_load
    unset -f _pyenv_load
    pip "$@"
  }

  pip3() {
    unset -f pyenv python python3 pip pip3 python2 pip2 pydoc 2>/dev/null
    _pyenv_load
    unset -f _pyenv_load
    pip3 "$@"
  }

  python2() {
    unset -f pyenv python python3 pip pip3 python2 pip2 pydoc 2>/dev/null
    _pyenv_load
    unset -f _pyenv_load
    python2 "$@"
  }

  pip2() {
    unset -f pyenv python python3 pip pip3 python2 pip2 pydoc 2>/dev/null
    _pyenv_load
    unset -f _pyenv_load
    pip2 "$@"
  }

  pydoc() {
    unset -f pyenv python python3 pip pip3 python2 pip2 pydoc 2>/dev/null
    _pyenv_load
    unset -f _pyenv_load
    pydoc "$@"
  }

else
  # Immediate loading
  eval "$("$_PYENV_BIN" init -)"
  if command -v pyenv-virtualenv-init &>/dev/null; then
    eval "$("$_PYENV_BIN" virtualenv-init -)"
  fi
  unset _PYENV_BIN
fi
