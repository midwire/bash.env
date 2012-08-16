#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage : $0 <COMMAND> [ARGS]"
  exit
fi

cmd="$1"
shift 1
args="$*"

function set_environment {
  if [ -n "$1" ]; then
    export RAILS_ENV="$1"
  fi
  if [ -z "$RAILS_ENV" ]; then
    echo "RAILS_ENV is not set and was not specified in arguments... exiting."
    exit
  fi
  if [ -f ~/$RAILS_ENV/set_env ]; then
    . ~/$RAILS_ENV/set_env
  else
    echo "~/$RAILS_ENV/set_env does not exist."
    echo "Are you sure you are on the right box?"
    exit
  fi
}

case "$cmd" in

start)  echo "Starting Pinkbox"
    # environment
    set_environment $1
    shift 1
    cd ~/$RAILS_ENV/apps/pinkbox/management
    # threads?
    if [ "$1" == "threads" ]; then
      ./bin/run ./etc/deployment_scripts/$RAILS_ENV/start_pinkbox_as_threads.ds
    else
      ./bin/run ./etc/deployment_scripts/$RAILS_ENV/start_pinkbox.ds
    fi
    ;;

stop)  echo "Stopping Pinkbox"
    # environment
    set_environment $1
    shift 1
    cd ~/$RAILS_ENV/apps/pinkbox/management
    # threads?
    ./bin/run etc/deployment_scripts/$RAILS_ENV/stop_pinkbox.ds
    ;;

check)  echo "Checking Pinkbox"
    # environment
    set_environment $1
    shift 1
    cd ~/$RAILS_ENV/apps/pinkbox/management
    # threads?
    ./bin/run etc/deployment_scripts/$RAILS_ENV/check_pinkbox.as
    ;;

tail)  echo "Tailing Pinkbox Logs"
    # environment
    set_environment $1
    shift 1
    cd /var/log/pinkbox/$RAILS_ENV
    # files
    tail -f ./rapid_decision/core_rindlets_* ./underwriting_system/underwriting_rindlets_* ./rinda_server/rinda_delivery.log
    ;;

update_code)  echo "Updating Pinkbox Code"
    # environment
    set_environment $1
    shift 1
    cd ~/$RAILS_ENV/apps/pinkbox
    for i in *; do \
      cd $i; echo "===== $i ====="; echo `pwd`; \
      git reset --hard; git pull; git submodule update; \
      rake clear_gems gems; rake gems; cd - ; \
    done
    ;;

mgr)  echo "Launching Pinkbox Console"
    # environment
    set_environment $1
    shift 1
    cd ~/$RAILS_ENV/apps/pinkbox/management
    # files
    ./bin/run console
    ;;

*) echo "That command is not in my vocabulary."
    ;;
esac
