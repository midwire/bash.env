# ChDir aliases
alias ..='cd ..'
alias ...='cd ../..'
alias 1..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'
alias blog='cd $HOME/Source/ruby/midwire.github.com'
alias dev='cd $HOME/development/apps/pinkbox'
alias home='cd $HOME'
alias rb='cd ~/Source/ruby'
alias src='cd ~/Source/ruby'

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

# Editing and Sourcing aliases
alias ees='. ~/.env/choose_os.sh'

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
alias mysql='mysql -uroot -pb0g0c1ty'
alias mysqladmin='mysqladmin -uroot -pb0g0c1ty'
alias path='echo $PATH'
alias pglog='tail -111f /usr/local/var/postgres84/server.log'
alias vi='mate'

# PINKBOX
alias pb_start='export RAILS_ENV="development"; cd $HOME/$RAILS_ENV/apps/pinkbox/management; rake startup && ./bin/run ./etc/deployment_scripts/$RAILS_ENV/start_pinkbox_as_threads.ds'
alias pb_starti='export RAILS_ENV="integration"; cd $HOME/$RAILS_ENV/apps/pinkbox/management; rake startup && ./bin/run ./etc/deployment_scripts/$RAILS_ENV/start_pinkbox_as_threads.ds'
alias pb_stop='export RAILS_ENV="development"; cd $HOME/$RAILS_ENV/apps/pinkbox/management; ./bin/run ./etc/deployment_scripts/$RAILS_ENV/stop_pinkbox.ds && rake shutdown shutdown_management_mq'
alias pb_stopi='export RAILS_ENV="integration"; cd $HOME/$RAILS_ENV/apps/pinkbox/management; ./bin/run ./etc/deployment_scripts/$RAILS_ENV/stop_pinkbox.ds && rake shutdown shutdown_management_mq'
alias pb_console='export RAILS_ENV="development"; cd $HOME/$RAILS_ENV/apps/pinkbox/management; ./bin/console'
alias pb_consolei='export RAILS_ENV="integration"; cd $HOME/$RAILS_ENV/apps/pinkbox/management; ./bin/console'
alias pb_development='export RAILS_ENV="development"; cd $HOME/$RAILS_ENV/apps/pinkbox/management'
alias pb_integration='export RAILS_ENV="integration"; cd $HOME/$RAILS_ENV/apps/pinkbox/management'
alias pb_logs='cd /var/log/pinkbox/development && ls -latF'
alias pb_logsi='cd /var/log/pinkbox/integration && ls -latF'
alias pb_t='tail -f /var/log/pinkbox/development/rapid_decision/core_rindlets_* /var/log/pinkbox/development/underwriting_system/underwriting_rindlets_*'
alias pb_tail='tail -1111f /var/log/pinkbox/development/rapid_decision/core_rindlets_* /var/log/pinkbox/development/underwriting_system/underwriting_rindlets_* /var/log/pinkbox/development/rinda_server/rinda_development.log'
alias fit='export RAILS_ENV="fitnesse"; cd $HOME/$RAILS_ENV/apps/fitnesse; rvm use ruby-1.8.7@cdirect; $HOME/$RAILS_ENV/apps/fitnesse/bin/fit'

# CONSUMER DIRECT
alias cdr='cd $HOME/development/apps/pinkbox/consumer_direct_web_site'
