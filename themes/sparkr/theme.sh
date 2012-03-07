#!/bin/bash
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

function the_theme {
	local thisdir=$(dirname $BASH_SOURCE)

	if [[ "$dot_env_home_host" == "$HOSTNAME" ]]; then
		. "${thisdir}/local.sh"
	else # We are on foreign soil
		. "${thisdir}/remote.sh"
	fi

PS2='> '
PS4='+ '
}

the_theme
