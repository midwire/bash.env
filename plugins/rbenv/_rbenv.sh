# rbenv plugin with lazy loading
# Set RBENV_LAZY=0 in your .bashrc before sourcing bash.env to disable lazy loading

# Add rbenv to path
pathmunge ~/.rbenv/bin before

# Check if rbenv binary is available (not function)
if ! command -v rbenv &>/dev/null; then
  return 0
fi

# Store the path to rbenv binary for use in lazy loading
_RBENV_BIN="$(command -v rbenv)"

# This function is useful if you have installed ruby-build as a rbenv plugin using Git
rbenv-update-versions() {
  # Update the ruby-build plugin repo
  local gitdir worktree
  gitdir="$("$_RBENV_BIN" root)/plugins/ruby-build/.git"
  worktree="$("$_RBENV_BIN" root)/plugins/ruby-build"
  if [[ -d "$gitdir" ]]; then
    git --git-dir="$gitdir" --work-tree="$worktree" pull
  else
    echo "ruby-build plugin not found or not installed via git"
  fi
}

# Lazy loading (default) or immediate loading
if [[ "${RBENV_LAZY:-1}" == "1" ]]; then

  _rbenv_load() {
    # Initialize rbenv using the binary path (not function)
    eval "$("$_RBENV_BIN" init -)"
    unset _RBENV_BIN
  }

  # Wrapper functions - each unsets itself FIRST to prevent recursion
  rbenv() {
    unset -f rbenv ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _rbenv_load
    unset -f _rbenv_load
    rbenv "$@"
  }

  ruby() {
    unset -f rbenv ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _rbenv_load
    unset -f _rbenv_load
    ruby "$@"
  }

  gem() {
    unset -f rbenv ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _rbenv_load
    unset -f _rbenv_load
    gem "$@"
  }

  bundle() {
    unset -f rbenv ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _rbenv_load
    unset -f _rbenv_load
    bundle "$@"
  }

  bundler() {
    unset -f rbenv ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _rbenv_load
    unset -f _rbenv_load
    bundler "$@"
  }

  irb() {
    unset -f rbenv ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _rbenv_load
    unset -f _rbenv_load
    irb "$@"
  }

  rake() {
    unset -f rbenv ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _rbenv_load
    unset -f _rbenv_load
    rake "$@"
  }

  rails() {
    unset -f rbenv ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _rbenv_load
    unset -f _rbenv_load
    rails "$@"
  }

  rspec() {
    unset -f rbenv ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _rbenv_load
    unset -f _rbenv_load
    rspec "$@"
  }

else
  # Immediate loading
  pathmunge ~/.rbenv/shims before
  eval "$("$_RBENV_BIN" init -)"
  unset _RBENV_BIN
fi
