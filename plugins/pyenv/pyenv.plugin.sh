# Simple plugin to load pyenv

if [ ! -d "$HOME/.pyenv" ]; then
  echo "WARNING: You have enabled the pyenv plugin but pyenv is not installed."
  echo "EXECUTE: git clone https://github.com/yyuu/pyenv.git ~/.pyenv"
else
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
  fi
fi
