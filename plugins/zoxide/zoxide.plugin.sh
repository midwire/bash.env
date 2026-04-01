# Initialize zoxide for smarter directory navigation (z command)

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi
