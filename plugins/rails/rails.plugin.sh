function _rails_command () {
  if [ -e "bin/rails" ]; then
    bin/rails $@
  elif [ -e "script/rails" ]; then
    ruby script/rails $@
  elif [ -e "script/server" ]; then
    ruby script/$@
  else
    rails $@
  fi
}

function _rake_command () {
  if [ -e "bin/rake" ]; then
    bin/rake $@
  else
    rake $@
  fi
}

# Logs
alias devlog='tail -f log/development.log'
alias prodlog='tail -f log/production.log'
alias testlog='tail -f log/test.log'

# Rails
alias rc='_rails_command console'
alias rd='_rails_command destroy'
alias re='echo $RAILS_ENV'
alias rdb='_rails_command dbconsole'
alias rg='_rails_command generate'
alias rp='_rails_command plugin'
alias ru='_rails_command runner'
alias rs='_rails_command server'
alias rsd='_rails_command server --debugger'
alias pryc='pry -r `test -f config/environment.rb && echo "./config/environment" || echo "./config/boot"`'

# Rake
alias rdm='_rake_command db:migrate'
alias rdr='_rake_command db:rollback'
alias rdbm='_rake_command db:migrate db:test:prepare'

# Set RAILS_ENV
alias red='export RAILS_ENV=development; echo "set RAILS_ENV=$RAILS_ENV"'
alias ret='export RAILS_ENV=test; echo "set RAILS_ENV=$RAILS_ENV"'
alias rep='export RAILS_ENV=production; echo "set RAILS_ENV=$RAILS_ENV"'
