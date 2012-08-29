#!/bin/bash
source "$dot_env_path/global/global_colors.sh"

topic="$1"
shift 1
args="$*"

case "$topic" in

amd-203)  echo_info ">>> Select Quote System"
    echo_info "     Only machine publicly accessible. This hosts Subversion and our SelectQuote system. "
    ;;

amd-213)  echo_info ">>> Hudson Unit Tests"
    echo_info "      Hudson build server - used primarily for running unit tests "
    ;;

amd-215)  echo_info ">>> Hudson Integration Tests"
    echo_info "       Hudson system integration test server "
    ;;

amd-230)  echo_info ">>> Pinkbox DELIVERY / UAT / RELEASE_CANDIDATE servers"
    echo_info ">>>               UAT: 3229"
    echo_info ">>>          DELIVERY: 7229"
    echo_info ">>> RELEASE_CANDIDATE: 6229"
    echo_info "    Rapid Decision System UAT (3220, 3229, etc) Rapid Decision System Delivery (7220, 7229, etc) Rapid Decision System Release Candidate (6220, 6229, etc) multiple environments for multiple projects. "
    ;;

amd-231)  echo_info ">>> Pinkbox DEMO server"
    echo_info "    Rapid Decision System Business demo server. This is a production server that the business uses to demo to business partners or potential partners (e.g. agents, agencies, underwriters, etc.) "
    ;;

amd-240)  echo_info ">>> Pinkbox SUPPORT server"
    echo_info "     Product promotion server. This is a production server that runs the code currently in production and is used for editing and promoting product changes. Environment is labeled 'support' "
    ;;

*) echo_error ">>> That topic is not in my vocabulary."
    ;;

esac
