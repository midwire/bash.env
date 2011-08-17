#!/bin/bash
# Solaris has a wonky, featureless /bin/ps, so try to use the ucb one
if [[ -x /usr/ucb/ps ]]; then
	PS="/usr/ucb/ps -el"
else
	PS="`which ps` ax"
fi

function prompt_command {
	# Show current git branch
	if [[ -x `which git` ]]; then
	  branch=$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "$(git branch | grep '^*' |sed s/\*\ //)"; fi)
	else
	  branch="nogit"
	fi
}
PROMPT_COMMAND=prompt_command

function pprompt {
	local        BG_BLACK="\[\033[0;40m\]"
	local          BG_RED="\[\033[0;41m\]"
	local        BG_GREEN="\[\033[0;42m\]"
	local        BG_BROWN="\[\033[0;43m\]"
	local         BG_BLUE="\[\033[0;44m\]"
	local      BG_MAGENTA="\[\033[0;45m\]"
	local         BG_CYAN="\[\033[0;46m\]"
	local   BG_LIGHT_GRAY="\[\033[0;47m\]"

	local           BLACK="\[\033[0;30m\]"
	local       DARK_GRAY="\[\033[1;30m\]"
	local             RED="\[\033[0;31m\]"
	local       LIGHT_RED="\[\033[1;31m\]"
	local           GREEN="\[\033[0;32m\]"
	local     LIGHT_GREEN="\[\033[1;32m\]"
	local           BROWN="\[\033[0;33m\]"
	local          YELLOW="\[\033[1;33m\]"
	local            BLUE="\[\033[0;34m\]"
	local      LIGHT_BLUE="\[\033[1;34m\]"
	local         MAGENTA="\[\033[0;35m\]"
	local   LIGHT_MAGENTA="\[\033[1;35m\]"
	local            CYAN="\[\033[0;36m\]"
	local      LIGHT_CYAN="\[\033[1;36m\]"
	local      LIGHT_GRAY="\[\033[0;37m\]"
	local           WHITE="\[\033[1;37m\]"
	local       NO_COLOUR="\[\033[0m\]"

	case $TERM in
		xterm*)
		  TITLEBAR='\[\033]0;\u@\H:\w\007\]'
		  ;;
		*)
		  TITLEBAR=""
		  ;;
	esac

PS1="$BLUE[$LIGHT_RED\!#|\jbg$BLUE]\
$BLUE[$LIGHT_CYAN\u@\H$BLUE]\
$BLUE[\
$WHITE\$($PS -el | wc -l | sed -e \"s: ::g\")proc\
$YELLOW (\${branch})\
$BLUE]\
\n\
$BLUE[$RED\$PWD$BLUE]\
$WHITE\$\
\
$NO_COLOUR "
PS2='> '
PS4='+ '
}
pprompt
