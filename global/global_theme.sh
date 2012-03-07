# In here we use different color definitions, wrapped with literal \[ and \]
# This prevents horizontal scrolling problems for prompts
# Don't use these colors for terminal output.
# Instead use 'global_colors.sh'
# See 'os' or 'host' prompt.sh files for the actual prompt settings

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

# Get 256 colors
function ext_color () { echo -ne "\[\033[38;5;$1m\]"; }

# The following are from Wayne Sequin's RVM
# http://beginrescueend.com
ps1_titlebar() {
  case $TERM in
    (xterm*|rxvt*)
      printf "%s" "\033]0;\\u@\\h: \W\\007"
      ;;
  esac
}

ps1_git_branch() {
  local branch=""
  shopt -s extglob # Important, for our nice matchers :)
  command -v git >/dev/null 2>&1 || {
    printf "[git not found]"
    return 0
  }
  branch=$(git symbolic-ref -q HEAD 2>/dev/null) || return 0 # Not in git repo.
  branch=${branch##refs/heads/}
  printf ${branch}
}

ps1_sha() {
  local sha1=""
  shopt -s extglob # Turns on this "${branch:-"(no branch)"}" kind of string matcher
  command -v git >/dev/null 2>&1 || {
    printf "[git not found]"
    return 0
  }
  sha1=$(git rev-parse --short --quiet HEAD)
  printf ${sha1}
}

ps1_git_status() {
  local git_status="$(git status 2>/dev/null)"
  [[ "${git_status}" = *deleted* ]]                    && printf "%s" "-"
  [[ "${git_status}" = *Untracked[[:space:]]files:* ]] && printf "%s" "+"
  [[ "${git_status}" = *modified:* ]]                  && printf "%s" "*"
}

ps1_rvm() {
  command -v rvm-prompt >/dev/null 2>&1 && printf "%s" " $(rvm-prompt) "
}

# Source the chosen theme:
themefile="${dot_env_path}/themes/${theme}/theme.sh"
if [[ -f ${themefile} ]]; then
	source "${themefile}"
else
	source "${dot_env_path}/themes/default/theme.sh"
fi
