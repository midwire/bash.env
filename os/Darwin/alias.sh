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
alias re='echo $RAILS_ENV'
alias rg='rails g'
alias rp='rails plugin'
alias rs='rails s'
alias sc='./script/console'
alias sd='./script/destroy'
alias sg='./script/generate'
alias sp='./script/plugin'
alias ss='./script/server'

# Directory Listing aliases
alias dir='ls -hFx'
alias l.='ls -d .* --color=tty'
alias l='ls -lathF'
alias L='ls -latrhF'
alias ll='ls -lFh'
alias lo='ls -laSFh'
alias vdir='ls --color=auto --format=long'

# Miscellaneous aliases
alias c='clear'
alias cls='clear'
alias h='history'
alias path='echo $PATH'
