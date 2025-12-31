# chruby plugin with lazy loading
# Set CHRUBY_LAZY=0 in your .bashrc before sourcing bash.env to disable lazy loading

THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Find chruby scripts
_chruby_scripts=()
if command -v brew &>/dev/null; then
  _brew_prefix="$(brew --prefix)"
  if [[ -r "$_brew_prefix/opt/chruby/share/chruby/chruby.sh" ]]; then
    _chruby_scripts=(
      "$_brew_prefix/opt/chruby/share/chruby/chruby.sh"
      "$_brew_prefix/opt/chruby/share/chruby/auto.sh"
    )
  fi
  unset _brew_prefix
fi

# Fallback to Linux locations
if [[ ${#_chruby_scripts[@]} -eq 0 ]]; then
  if [[ -r "/usr/local/share/chruby/chruby.sh" ]]; then
    _chruby_scripts=(
      "/usr/local/share/chruby/chruby.sh"
      "/usr/local/share/chruby/auto.sh"
    )
  fi
fi

# Check if chruby is available
if [[ ${#_chruby_scripts[@]} -eq 0 ]]; then
  unset _chruby_scripts
  return 0
fi

# Lazy loading (default) or immediate loading
if [[ "${CHRUBY_LAZY:-1}" == "1" ]]; then
  # Commands that should trigger chruby loading
  _chruby_lazy_cmds=(chruby ruby gem bundle bundler irb rake rails rspec)

  _chruby_load() {
    # Remove lazy loading functions
    for cmd in "${_chruby_lazy_cmds[@]}"; do
      unset -f "$cmd" 2>/dev/null
    done
    unset -f _chruby_load
    unset _chruby_lazy_cmds

    # Source chruby scripts
    for script in "${_chruby_scripts[@]}"; do
      [[ -r "$script" ]] && . "$script"
    done
    unset _chruby_scripts
  }

  # Create lazy loading wrapper for each command
  for cmd in "${_chruby_lazy_cmds[@]}"; do
    eval "
      $cmd() {
        _chruby_load
        $cmd \"\$@\"
      }
    "
  done
else
  # Immediate loading
  for script in "${_chruby_scripts[@]}"; do
    [[ -r "$script" ]] && . "$script"
  done
  unset _chruby_scripts
fi
