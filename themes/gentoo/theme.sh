#!/bin/bash
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

function the_theme {
  local thisdir=$(dirname $BASH_SOURCE)
  local prompt_char=$(ps1_prompt_char)

  PS1="\[\033[01;31m\]\h\[\033[01;34m\] \W ${prompt_char}\[\033[00m\] "

PS2='> '
PS4='+ '
}

the_theme
