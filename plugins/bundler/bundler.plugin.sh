THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

alias be="bundle exec"
alias bi="bundle install"
alias bil="bi --local"
alias bl="bundle list"
alias bp="bundle package"
alias bu="bundle update"
alias bo="bundle open"

# With Rails
alias bers="bundle exec rails server"
alias berc="bundle exec rails console"
alias berg="bundle exec rails generate"
alias berd="bundle exec rails destroy"
alias bedb="bundle exec rails db"

source "$THISDIR/_bundler.sh"
