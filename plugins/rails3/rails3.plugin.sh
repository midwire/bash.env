# Rails 3 aliases, backwards-compatible with Rails 2.

function _rails_command () {
  if [ -e "script/server" ]; then
    ruby script/$@
  else
    ruby script/rails $@
  fi
}

alias rc='_rails_command console'
alias rd='_rails_command destroy'
alias re='echo $RAILS_ENV'
alias rdb='_rails_command dbconsole'
alias rdbm='rake db:migrate db:test:prepare'
alias rg='_rails_command generate'
alias rp='_rails_command plugin'
alias ru='_rails_command runner'
alias rs='_rails_command server'
alias rsd='_rails_command server --debugger'
alias devlog='tail -f log/development.log'
alias rdm='rake db:migrate'
alias rdr='rake db:rollback'
alias pryc='pry -r `test -f config/environment.rb && echo "./config/environment" || echo "./config/boot"`'
