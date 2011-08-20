# ChDir aliases
alias ..='cd ..'
alias ...='cd ../..'
alias 1..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

# Git aliases
alias add='git add'
alias branch='git branch'
alias co='git checkout'
alias commit='git commit'
alias gadd='git add .'
alias gt='gittower'
alias merge='git merge'
alias pull='git pull'
alias push='git push'
alias st='git status'

# Rails aliases
alias a='autotest -rails'
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"
alias rc='rails c'
alias rd='rails destroy'
alias rg='rails g'
alias rp='rails plugin'
alias rs='rails s'
alias sc='./script/console'
alias sd='./script/destroy'
alias sg='./script/generate'
alias sp='./script/plugin'
alias ss='./script/server'

# Textmate Editing and Sourcing aliases
alias e='mate .'
alias ea='mate ~/.env/Darwin/alias.sh'
alias eas='. ~/.env/Darwin/alias.sh'
alias ee='mate ~/.env'
alias ees='. ~/.env/source.sh'
alias ef='mate ~/.env/Darwin/functions.sh'
alias efs='. ~/.env/Darwin/functions.sh'
alias egen='mate ~/.rails/generators'
alias ep='mate ~/.env/Darwin/path.sh'
alias eps='. ~/.env/Darwin/path.sh'
alias m='mate'

# Directory Listing aliases
alias dir='ls -GhFx'
alias l.='ls -Gd .* --color=tty'
alias l='ls -GlathF'
alias L='ls -GlatrhF'
alias ll='ls -lGFh'
alias lo='ls -laGSFh'
alias vdir='ls --color=auto --format=long'

# Miscellaneous aliases
alias c='clear'
alias cls='clear'
alias h='history'
alias path='echo $PATH'
alias vi='mate'
