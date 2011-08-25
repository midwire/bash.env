# Vi Editing and Sourcing aliases
alias ea='vi ~/.env/host/ub41/alias.sh'
alias eas='. ~/.env/host/ub41/alias.sh'
alias ees='. ~/.env/source.sh'
alias ef='vi ~/.env/host/ub41/functions.sh'
alias efs='. ~/.env/host/ub41/functions.sh'
alias ep='vi ~/.env/host/ub41/path.sh'
alias eps='. ~/.env/host/ub41/path.sh'
alias eh="vi ~/.env/host/$HOSTNAME/*.sh"
alias ehs=". ~/.env/host/$HOSTNAME/*.sh"

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
alias fit='RAILS_ENV="fitnesse"; rvm use ruby-1.8.7; $HOME/$RAILS_ENV/apps/fitnesse/bin/fit'
