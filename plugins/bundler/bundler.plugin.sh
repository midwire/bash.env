THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias be="bundle exec"
alias bi="bundle install"
alias bil="bi --local"
alias bl="bundle list"
alias bp="bundle package"
alias bu="bundle update"

source "$THISDIR/_bundler.sh"
