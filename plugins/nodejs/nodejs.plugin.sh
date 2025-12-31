# Node.js plugin - adds npm global binaries to path
# For version management, use the nvm plugin instead

# Add npm global bin directory to path
if command -v npm &>/dev/null; then
  _npm_prefix="$(npm config get prefix 2>/dev/null)"
  if [[ -d "$_npm_prefix/bin" ]]; then
    pathmunge "$_npm_prefix/bin"
  fi
  unset _npm_prefix
elif [[ -d /usr/local/share/npm/bin ]]; then
  # Legacy path
  pathmunge "/usr/local/share/npm/bin"
fi

# Common Node.js aliases
alias npmg='npm list -g --depth=0'
alias npmup='npm update -g'
