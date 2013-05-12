THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Bundle Exec aliases
alias be="bundle exec"
alias bers="bundle exec rails s"
alias berc="bundle exec rails c"

alias bi="bundle install --path vendor"
alias bil="bi --local"
alias binit="bi && bundle package && echo 'vendor/ruby' >> .gitignore"
alias bl="bundle list"
alias bp="bundle package"
alias bu="bundle update"

source "$THISDIR/_bundler.sh"
