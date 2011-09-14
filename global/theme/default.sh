#!/bin/bash

function prompt_command {
  branch=$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "$(git branch | grep '^*' |sed s/\*\ //)"; fi)
	ruby_ver="$(ruby -v &>/dev/null; if [ $? -eq 0 ]; then echo "$(ruby -e 'print "ruby-#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"')"; else echo "no-ruby"; fi)"
}
PROMPT_COMMAND=prompt_command

function power_prompt {
	case $TERM in
		xterm*)
		  TITLEBAR='\[\033]0;\u@\h:\w\007\]'
		  ;;
		*)
		  TITLEBAR=""
		  ;;
	esac

	if [ $UID -eq 0 ]; then
PS1="╭─${TITLEBAR}\
${BG_RED}${LIGHT_WHITE}\u@\h${CYAN} \w\
${RED} <\${ruby_ver}>\
${YELLOW} (\${branch})\n\
${LIGHT_RED}∹\
$NO_COLOR "
	else
PS1="╭─${TITLEBAR}\
${LIGHT_GREEN}\u@\h${CYAN} \w\
${RED} <\${ruby_ver}>\
${YELLOW} (\${branch})\n\
${WHITE}⊱\
$NO_COLOR "
	fi

PS2='> '
PS4='+ '
}

power_prompt
