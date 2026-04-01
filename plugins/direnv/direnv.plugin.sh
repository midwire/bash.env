# Hook direnv into the shell for automatic .envrc loading

if command -v direnv &>/dev/null; then
  eval "$(direnv hook bash)"
fi
