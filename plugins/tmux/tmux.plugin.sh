THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# aliases
alias tml='tmux list-sessions'
alias tmks='tmux kill-session'
alias etmx='edit ~/.tmux.conf'
alias tma='alias|grep tmux'

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'
