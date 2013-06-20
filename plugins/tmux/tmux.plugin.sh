THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# aliases
alias tml='tmux list-sessions'
alias tmw='tmux attach -t work || tmux new -s work'
alias tms='tmux attach -t servers || tmux new -s servers'
alias tmd='tmux attach -t dotfile || tmux new -s dotfile'
alias tmks='tmux kill-session'
alias etmx='edit ~/.tmux.conf'

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
