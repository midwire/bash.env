THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# aliases
alias tml='tmux list-sessions'
alias tmw='tmux attach -t work || tmux new -s work'
alias tmk='tmux list-keys'
