# Colored output and functions for info, warn, error
# Include this file to use it

BG_BLACK="\033[0;40m"
BG_RED="\033[0;41m"
BG_GREEN="\033[0;42m"
BG_BROWN="\033[0;43m"
BG_BLUE="\033[0;44m"
BG_MAGENTA="\033[0;45m"
BG_CYAN="\033[0;46m"
BG_LIGHT_GRAY="\033[0;47m"

BLACK="\033[0;30m"
DARK_GRAY="\033[1;30m"
RED="\033[0;31m"
LIGHT_RED="\033[1;31m"
GREEN="\033[0;32m"
LIGHT_GREEN="\033[1;32m"
BROWN="\033[0;33m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
LIGHT_BLUE="\033[1;34m"
MAGENTA="\033[0;35m"
LIGHT_MAGENTA="\033[1;35m"
CYAN="\033[0;36m"
LIGHT_CYAN="\033[1;36m"
LIGHT_GRAY="\033[0;37m"
WHITE="\033[1;37m"
NO_COLOR="\033[0m"

NORMAL=$NO_COLOR
INFO=$LIGHT_GREEN
WARN=$YELLOW
ERROR=$LIGHT_RED

echo_info() {
  echo -e "${INFO}> $@${NORMAL}"
  return 0
}

echo_warn() {
  echo -e "${WARN}>> $@${NORMAL}"
  return 0
}

echo_error() {
  echo -e "${ERROR}>>> $*${NORMAL}"
  return 0
}
