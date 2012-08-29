#!/bin/bash
# Usage:
#   pinkbox <action> <environment> <args>
THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$dot_env_path/global/global_colors.sh"
source "$THISDIR/_pinkbox.sh"

if [ $# -lt 1 ]; then
  echo_warn ">>> Usage : $0 <ACTION> <ENVIRONMENT> [ARGS]"
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
    echo_error ">>> RAILS_ENV is not set and was not specified in arguments... exiting."
    exit
  fi
  if [ -f ~/$RAILS_ENV/set_env ]; then
    . ~/$RAILS_ENV/set_env
  else
    echo_warn ">>> ~/$RAILS_ENV/set_env does not exist."
    echo_warn ">>> Are you sure you are on the right box?"
    exit
  fi
}

case "$cmd" in

start)  echo_info ">>> Starting Pinkbox"
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

stop)  echo_info ">>> Stopping Pinkbox"
    # environment
    set_environment $1
    shift 1
    cd ~/$RAILS_ENV/apps/pinkbox/management
    # threads?
    ./bin/run etc/deployment_scripts/$RAILS_ENV/stop_pinkbox.ds
    ;;

check)  echo_info ">>> Checking Pinkbox"
    # environment
    set_environment $1
    shift 1
    cd ~/$RAILS_ENV/apps/pinkbox/management
    # threads?
    ./bin/run etc/deployment_scripts/$RAILS_ENV/check_pinkbox.as
    ;;

tail)  echo_info ">>> Tailing Pinkbox Logs"
    # example: pinkbox tail delivery
    set_environment $1
    shift 1
    cd /var/log/pinkbox/$RAILS_ENV
    # files
    tail -f ./rapid_decision/core_rindlets_* ./underwriting_system/underwriting_rindlets_* ./rinda_server/rinda_delivery.log
    ;;

update_code)  echo_info ">>> Updating Pinkbox Code"
    # example: pinkbox update_code uat
    set_environment $1
    shift 1
    cd ~/$RAILS_ENV/apps/pinkbox
    for i in *; do \
      cd $i; echo "===== $i ====="; echo `pwd`; \
      git reset --hard; git pull; git submodule update; \
      rake clear_gems gems; rake gems; cd - ; \
    done
    # Generate deployment scripts
    cd ~/$RAILS_ENV/apps/pinkbox/management
    echo_info ">>> Generating deployment scripts"
    rake generate:deployment
    ;;

mgr)  echo_info ">>> Launching Pinkbox Console"
    # example: pinkbox mgr uat
    set_environment $1
    shift 1
    cd ~/$RAILS_ENV/apps/pinkbox/management
    # files
    ./bin/console
    ;;

help) echo ""
    if [ -z "$1" ]; then
        echo_info ">>> Possible Commands:"
        echo_info ">>> pinkbox start <ENVIRONMENT> [thread]"
        echo_info ">>> pinkbox stop <ENVIRONMENT>"
        echo_info ">>> pinkbox check <ENVIRONMENT>"
        echo_info ">>> pinkbox tail <ENVIRONMENT>"
        echo_info ">>> pinkbox update_code <ENVIRONMENT>"
        echo_info ">>> pinkbox mgr <ENVIRONMENT>"
        echo ""
        echo_info ">>> Angle bracketed commands are required <required>"
        echo_info ">>> Square bracketed commands are optional [optional]"
    else
        $THISDIR/pinkbox_help.sh "$*"
    fi
    ;;

*) echo_error ">>> That command is not in my vocabulary."
    ;;
esac
