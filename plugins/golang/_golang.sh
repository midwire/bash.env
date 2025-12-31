# Set GOPATH if not already set (modern Go uses ~/go by default)
export GOPATH="${GOPATH:-$HOME/go}"

# Add Go binaries to path
pathmunge "$GOPATH/bin"

# Add Go installation to path (supports Homebrew on Intel and Apple Silicon)
if command -v brew &>/dev/null; then
  go_prefix="$(brew --prefix go 2>/dev/null)"
  if [[ -d "$go_prefix/libexec/bin" ]]; then
    pathmunge "$go_prefix/libexec/bin"
  fi
  unset go_prefix
elif [[ -d /usr/local/go/bin ]]; then
  # Standard Go installation
  pathmunge "/usr/local/go/bin"
fi
