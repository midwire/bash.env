# NVM (Node Version Manager) plugin with lazy loading
# Set NVM_LAZY=0 in your .bashrc before sourcing bash.env to disable lazy loading

export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

# Check if nvm is installed
if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
  echo "WARNING: nvm not found at $NVM_DIR"
  echo "Install via: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash"
  return 0
fi

# Store the nvm script path for use in lazy loading
_NVM_SCRIPT="$NVM_DIR/nvm.sh"
_NVM_COMPLETION="$NVM_DIR/bash_completion"

# Lazy loading (default) or immediate loading
if [[ "${NVM_LAZY:-1}" == "1" ]]; then

  _nvm_load() {
    # Load nvm using stored path
    . "$_NVM_SCRIPT"
    [[ -s "$_NVM_COMPLETION" ]] && . "$_NVM_COMPLETION"
    unset _NVM_SCRIPT _NVM_COMPLETION
  }

  # Wrapper functions - each unsets itself FIRST to prevent recursion
  nvm() {
    unset -f nvm node npm npx yarn pnpm corepack 2>/dev/null
    _nvm_load
    unset -f _nvm_load
    nvm "$@"
  }

  node() {
    unset -f nvm node npm npx yarn pnpm corepack 2>/dev/null
    _nvm_load
    unset -f _nvm_load
    node "$@"
  }

  npm() {
    unset -f nvm node npm npx yarn pnpm corepack 2>/dev/null
    _nvm_load
    unset -f _nvm_load
    npm "$@"
  }

  npx() {
    unset -f nvm node npm npx yarn pnpm corepack 2>/dev/null
    _nvm_load
    unset -f _nvm_load
    npx "$@"
  }

  yarn() {
    unset -f nvm node npm npx yarn pnpm corepack 2>/dev/null
    _nvm_load
    unset -f _nvm_load
    yarn "$@"
  }

  pnpm() {
    unset -f nvm node npm npx yarn pnpm corepack 2>/dev/null
    _nvm_load
    unset -f _nvm_load
    pnpm "$@"
  }

  corepack() {
    unset -f nvm node npm npx yarn pnpm corepack 2>/dev/null
    _nvm_load
    unset -f _nvm_load
    corepack "$@"
  }

else
  # Immediate loading
  . "$_NVM_SCRIPT"
  [[ -s "$_NVM_COMPLETION" ]] && . "$_NVM_COMPLETION"
  unset _NVM_SCRIPT _NVM_COMPLETION
fi
