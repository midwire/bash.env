# ChDir aliases
alias blog='cd $HOME/Source/ruby/midwire.github.com'
alias dev='cd $HOME/development/apps/pinkbox'
alias home='cd $HOME'
alias rb='cd ~/Source/ruby'
alias src='cd ~/Source'

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
alias pb_t='tail -f /var/log/pinkbox/$RAILS_ENV/rapid_decision/core_rindlets_* /var/log/pinkbox/$RAILS_ENV/underwriting_system/underwriting_rindlets_*'
alias pb_tail='tail -1111f /var/log/pinkbox/$RAILS_ENV/rapid_decision/core_rindlets_* /var/log/pinkbox/$RAILS_ENV/underwriting_system/underwriting_rindlets_* /var/log/pinkbox/$RAILS_ENV/rinda_server/rinda_development.log'
alias fit='RAILS_ENV="fitnesse"; cd $HOME/$RAILS_ENV/apps/fitnesse; rvm use ruby-1.8.7@cdirect; $HOME/$RAILS_ENV/apps/fitnesse/bin/fit'

alias prod='$HOME/development/apps/pinkbox/dev_util/script/production'
alias rl='prod tail_rinda_logs'

# CONSUMER DIRECT
alias cdr='cd $HOME/development/apps/consumer_direct/consumer_direct_web_site'

# DANGEROUS
alias shove="git add .; git commit -m 'latest changes'; git push origin $branch"
