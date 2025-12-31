# Add the path if cargo is installed
if [[ -d "$HOME/.cargo/bin" ]]; then
  pathmunge "$HOME/.cargo/bin"
fi

# Source the environment if it exists
if [[ -r "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi
