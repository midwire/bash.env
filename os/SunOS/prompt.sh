#!/bin/bash
. "${DOT_ENV_PATH}/global/global_prompt.sh"

function prompt_command {
	# Show current git branch
  branch=$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "$(git branch | grep '^*' |sed s/\*\ //)"; else echo "no-repo"; fi)
  ruby_ver="$(ruby -v &>/dev/null; if [ $? -eq 0 ]; then echo "$(ruby -e 'print RUBY_VERSION')"; else echo "no-ruby"; fi)"
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
$WHITE(ruby v\${ruby_ver})\
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
