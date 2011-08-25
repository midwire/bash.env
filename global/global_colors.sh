# Colored output and functions for info, warn, error
# Include this file to use it

if [[ -x `which tput` ]]; then
	tput init
	BG_BLACK="\[$(tput setab 0)\]"
	BG_RED="\[$(tput setab 1)\]"
	BG_GREEN="\[$(tput setab 2)\]"
	BG_BROWN="\[$(tput setab 3)\]"
	BG_BLUE="\[$(tput setab 4)\]"
	BG_MAGENTA="\[$(tput setab 5)\]"
	BG_CYAN="\[$(tput setab 6)\]"
	BG_LIGHT_GRAY="\[$(tput setab 7)\]"

	BLACK="\[$(tput sgr0; tput setaf 0)\]"
	DARK_GRAY="\[$(tput bold; tput setaf 0)\]"
	RED="\[$(tput sgr0; tput setaf 1)\]"
	LIGHT_RED="\[$(tput bold; tput setaf 1)\]"
	GREEN="\[$(tput sgr0; tput setaf 2)\]"
	LIGHT_GREEN="\[$(tput bold; tput setaf 2)\]"
	BROWN="\[$(tput sgr0; tput setaf 3)\]"
	YELLOW="\[$(tput bold; tput setaf 3)\]"
	BLUE="\[$(tput sgr0; tput setaf 4)\]"
	LIGHT_BLUE="\[$(tput bold; tput setaf 4)\]"
	MAGENTA="\[$(tput sgr0; tput setaf 5)\]"
	LIGHT_MAGENTA="\[$(tput bold; tput setaf 5)\]"
	CYAN="\[$(tput sgr0; tput setaf 6)\]"
	LIGHT_CYAN="\[$(tput bold; tput setaf 6)\]"
	LIGHT_GRAY="\[$(tput sgr0; tput setaf 7)\]"
	WHITE="\[$(tput bold; tput setaf 7)\]"
	NO_COLOR="\[$(tput sgr0)\]"
else
	BG_BLACK="\[\033[0;40m\]"
	BG_RED="\[\033[0;41m\]"
	BG_GREEN="\[\033[0;42m\]"
	BG_BROWN="\[\033[0;43m\]"
	BG_BLUE="\[\033[0;44m\]"
	BG_MAGENTA="\[\033[0;45m\]"
	BG_CYAN="\[\033[0;46m\]"
	BG_LIGHT_GRAY="\[\033[0;47m\]"

	BLACK="\[\033[0;30m\]"
	DARK_GRAY="\[\033[1;30m\]"
	RED="\[\033[0;31m\]"
	LIGHT_RED="\[\033[1;31m\]"
	GREEN="\[\033[0;32m\]"
	LIGHT_GREEN="\[\033[1;32m\]"
	BROWN="\[\033[0;33m\]"
	YELLOW="\[\033[1;33m\]"
	BLUE="\[\033[0;34m\]"
	LIGHT_BLUE="\[\033[1;34m\]"
	MAGENTA="\[\033[0;35m\]"
	LIGHT_MAGENTA="\[\033[1;35m\]"
	CYAN="\[\033[0;36m\]"
	LIGHT_CYAN="\[\033[1;36m\]"
	LIGHT_GRAY="\[\033[0;37m\]"
	WHITE="\[\033[1;37m\]"
	NO_COLOR="\[\033[0m\]"
fi

NORMAL=$NO_COLOR
INFO=$LIGHT_GREEN
WARN=$YELLOW
ERROR=$LIGHT_RED

echo_info() {
  echo -e "${INFO}$@${NORMAL}"
  return 0
}

echo_warn() {
  echo -e "${WARN}$@${NORMAL}"
  return 0
}

echo_error() {
  echo -e "${ERROR}$*${NORMAL}"
  return 0
}
