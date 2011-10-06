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

# The following are from Wayne Sequin's RVM
# http://beginrescueend.com
ps1_titlebar() {
  case $TERM in
    (xterm*|rxvt*)
      printf "%s" "\033]0;\\u@\\h: \W\\007"
      ;;
  esac
}

ps1_identity() {
  if (( $UID == 0 )) ; then
    printf "%s" "\[\033[31m\]\\u\[\033[0m\]@\[\033[36m\]\\h\[\033[35m\]:\w\[\033[0m\] "
  else
    printf "%s" "\[\033[32m\]\\u\[\033[0m\]@\[\033[36m\]\\h\[\033[35m\]:\w\[\033[0m\] "
  fi
}

ps1_git() {
  local branch="" sha1="" line="" attr="" color=0

  shopt -s extglob # Important, for our nice matchers :)

  command -v git >/dev/null 2>&1 || {
    printf " \033[1;37m\033[41m[git not found]\033[m "
    return 0
  }

  branch=$(git symbolic-ref -q HEAD 2>/dev/null) || return 0 # Not in git repo.
  branch=${branch##refs/heads/}

  # Now we display the branch.
  sha1=$(git rev-parse --short --quiet HEAD)

  case "${branch:-"(no branch)"}" in
   production|prod) attr="1;37m\033[" ; color=41 ;; # red
   master|deploy)   color=31                     ;; # red
   stage|staging)   color=33                     ;; # yellow
   dev|develop|development) color=34             ;; # blue
   next)            color=36                     ;; # gray
   *)
     if [[ -n "${branch}" ]] ; then # Feature Branch :)
       color=32 # green
     else
       color=0 # reset
     fi
     ;;
  esac

  [[ $color -gt 0 ]] &&
    printf "\[\033[${attr}${color}m\](git:${branch}$(ps1_git_status):$sha1)\[\033[0m\] "
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

#  Call ps1_update within your PROMPT_COMMAND
#
# The PROMPT_COMMAND is used to help the prompt work if the separator is not a new line.
# In the event that the separtor is not a new line, the prompt line may become distored if
# you add or delete a certian number of characters, making the string wider than the
# $COLUMNS + len(your_input_line).
# This orginally was done with callbacks within the PS1 to add in things like the git
# commit, but this results in the PS1 being of an unknown width which results in the prompt
# being distored if you add or remove a certain number of characters. To work around this
# it now uses the PROMPT_COMMAND callback to re-set the PS1 with a known width of chracters
# each time a new command is entered. see PROMPT_COMMAND for more details.
#

# Source the chosen theme:
themefile="${DOT_ENV_PATH}/global/theme/${bash_prompt}/${bash_prompt}.sh"
if [[ -f ${themefile} ]]; then
	. "${themefile}"
else
	. "${DOT_ENV_PATH}/global/theme/default/default.sh"
fi
