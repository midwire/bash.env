THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if command -v fzf &>/dev/null; then
  [[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
else
  echo "Please install 'fzf' or disable the Bash.env plugin: https://github.com/junegunn/fzf#installation"
fi
