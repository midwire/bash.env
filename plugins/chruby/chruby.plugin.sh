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

  _chruby_load() {
    # Source chruby scripts using stored paths
    for script in "${_chruby_scripts[@]}"; do
      [[ -r "$script" ]] && . "$script"
    done
    unset _chruby_scripts
  }

  # Wrapper functions - each unsets itself FIRST to prevent recursion
  chruby() {
    unset -f chruby ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _chruby_load
    unset -f _chruby_load
    chruby "$@"
  }

  ruby() {
    unset -f chruby ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _chruby_load
    unset -f _chruby_load
    ruby "$@"
  }

  gem() {
    unset -f chruby ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _chruby_load
    unset -f _chruby_load
    gem "$@"
  }

  bundle() {
    unset -f chruby ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _chruby_load
    unset -f _chruby_load
    bundle "$@"
  }

  bundler() {
    unset -f chruby ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _chruby_load
    unset -f _chruby_load
    bundler "$@"
  }

  irb() {
    unset -f chruby ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _chruby_load
    unset -f _chruby_load
    irb "$@"
  }

  rake() {
    unset -f chruby ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _chruby_load
    unset -f _chruby_load
    rake "$@"
  }

  rails() {
    unset -f chruby ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _chruby_load
    unset -f _chruby_load
    rails "$@"
  }

  rspec() {
    unset -f chruby ruby gem bundle bundler irb rake rails rspec 2>/dev/null
    _chruby_load
    unset -f _chruby_load
    rspec "$@"
  }

else
  # Immediate loading
  for script in "${_chruby_scripts[@]}"; do
    [[ -r "$script" ]] && . "$script"
  done
  unset _chruby_scripts
fi
