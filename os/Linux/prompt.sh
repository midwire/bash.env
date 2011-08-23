#!/bin/bash
. "${DOT_ENV_PATH}/global/global_colors.sh"

function prompt_command {
	# Show current git branch
  branch=$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "$(git branch | grep '^*' |sed s/\*\ //)"; fi)
  # ruby_ver="$(ruby -v &>/dev/null; if [ $? -eq 0 ]; then echo "$(ruby -e 'print RUBY_VERSION')"; else echo "no-ruby"; fi)"
  ruby_ver="$(ruby -v &>/dev/null; if [ $? -eq 0 ]; then echo "$(ruby -v)"; else echo "no-ruby"; fi)"
	# proc_count=$(ps ax | wc -l | sed -e "s: ::g")
}

PROMPT_COMMAND=prompt_command

function power_prompt {
	case $TERM in
		xterm*)
		  TITLEBAR='\[\033]0;\u@\H:\w\007\]'
		  ;;
		*)
		  TITLEBAR=""
		  ;;
	esac

PS1="$TITLEBAR\
$BLUE[$LIGHT_RED\!#|\jbg$BLUE]\
$BLUE[$BG_RED$WHITE\u@\H$BLUE]\
$BLUE[\
$WHITE($ruby_ver)\
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

power_prompt
