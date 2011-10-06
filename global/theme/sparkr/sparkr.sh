#!/bin/bash
THISDIR=$(dirname $BASH_SOURCE)

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

	if [[ "$DOT_ENV_HOME_HOST" == "$HOSTNAME" ]]; then
		. "${THISDIR}/local.sh"
	else # We are on foreign soil
		. "${THISDIR}/remote.sh"
	fi

PS2='> '
PS4='+ '
}

power_prompt
