# NVM (Node Version Manager) plugin with lazy loading
# Set NVM_LAZY=0 in your .bashrc before sourcing bash.env to disable lazy loading

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

# Check if nvm is installed
if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
  echo "WARNING: nvm not found at $NVM_DIR"
  echo "Install via: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash"
  return 0
fi

# Lazy loading (default) or immediate loading
if [[ "${NVM_LAZY:-1}" == "1" ]]; then
  # Commands that should trigger nvm loading
  _nvm_lazy_cmds=(nvm node npm npx yarn pnpm corepack)

  _nvm_load() {
    # Remove lazy loading functions
    for cmd in "${_nvm_lazy_cmds[@]}"; do
      unset -f "$cmd" 2>/dev/null
    done
    unset -f _nvm_load
    unset _nvm_lazy_cmds

    # Load nvm
    . "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
  }

  # Create lazy loading wrapper for each command
  for cmd in "${_nvm_lazy_cmds[@]}"; do
    eval "
      $cmd() {
        _nvm_load
        $cmd \"\$@\"
      }
    "
  done
else
  # Immediate loading
  . "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
fi
