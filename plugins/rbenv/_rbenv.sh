# rbenv plugin with lazy loading
# Set RBENV_LAZY=0 in your .bashrc before sourcing bash.env to disable lazy loading

# Add rbenv to path
pathmunge ~/.rbenv/bin before

# Check if rbenv is available
if ! command -v rbenv &>/dev/null; then
  return 0
fi

# This function is useful if you have installed ruby-build as a rbenv plugin using Git
rbenv-update-versions() {
  # Update the ruby-build plugin repo
  local gitdir worktree
  gitdir="$(rbenv root)/plugins/ruby-build/.git"
  worktree="$(rbenv root)/plugins/ruby-build"
  if [[ -d "$gitdir" ]]; then
    git --git-dir="$gitdir" --work-tree="$worktree" pull
  else
    echo "ruby-build plugin not found or not installed via git"
  fi
}

# Lazy loading (default) or immediate loading
if [[ "${RBENV_LAZY:-1}" == "1" ]]; then
  # Commands that should trigger rbenv loading
  _rbenv_lazy_cmds=(rbenv ruby gem bundle bundler irb rake rails rspec)

  _rbenv_load() {
    # Remove lazy loading functions
    for cmd in "${_rbenv_lazy_cmds[@]}"; do
      unset -f "$cmd" 2>/dev/null
    done
    unset -f _rbenv_load
    unset _rbenv_lazy_cmds

    # Initialize rbenv and add shims to path
    eval "$(rbenv init -)"
  }

  # Create lazy loading wrapper for each command
  for cmd in "${_rbenv_lazy_cmds[@]}"; do
    eval "
      $cmd() {
        _rbenv_load
        $cmd \"\$@\"
      }
    "
  done
else
  # Immediate loading
  pathmunge ~/.rbenv/shims before
  eval "$(rbenv init -)"
fi
