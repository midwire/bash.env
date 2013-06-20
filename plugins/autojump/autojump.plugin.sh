THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

alias jp="j ${PWD}"
alias jl='j --stat'
