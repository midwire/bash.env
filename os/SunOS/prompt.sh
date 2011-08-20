#!/bin/bash
. "${DOT_ENV_PATH}/global/global_colors.sh"

# Solaris has a wonky, featureless /bin/ps, so try to use the ucb one
if [[ -x /usr/ucb/ps ]]; then
	PS="/usr/ucb/ps ax"
else
	PS="`which ps` -el"
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

	case $TERM in
		xterm*)
		  TITLEBAR='\[\033]0;\u@\H:\w\007\]'
		  ;;
		*)
		  TITLEBAR=""
		  ;;
	esac

PS1="$BLUE[$LIGHT_RED\!#|\jbg$BLUE]\
$BLUE[$BG_RED$WHITE\u@\H$BLUE]\
$BLUE[\
$WHITE\$($PS | wc -l | sed -e \"s: ::g\")proc\
$YELLOW (\${branch})\
$BLUE]\
\n\
$BLUE[$RED\$PWD$BLUE]\
$WHITE\$\
\
$NO_COLOR "

PS2='> '

PS4='+ '
}
pprompt
