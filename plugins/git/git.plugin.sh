THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Git aliases
alias add='git add'
alias branch='git branch'
alias co='git checkout'
alias commit='git commit'
alias fetch='git fetch'
alias gadd='git add .'
alias gt='gittower'
alias merge='git merge'
alias pull='git pull'
alias push='git push'
alias st='git status'

source "$THISDIR/_git.sh"
