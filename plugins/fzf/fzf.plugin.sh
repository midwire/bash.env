THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ -x `which fzf` ]]; then
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
else
  echo "Please install 'fzf' or disable the Bash.env plugin: https://github.com/junegunn/fzf#using-homebrew-or-linuxbrew"
fi
