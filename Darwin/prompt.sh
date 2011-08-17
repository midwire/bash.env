#!/bin/bash
#----------------------------------------------------------------------
# POWER USER PROMPT "pprom2"
#----------------------------------------------------------------------
# Created August 98,
# Last Modified 08/16/2011 by CBlackburn

function prompt_command {
  # Create TotalMeg variable: sum of visible file sizes in current directory
  # local TotalBytes=0
  # for Bytes in $(\ls -l | grep "^-" | awk '{print $5}'); do
  #     let TotalBytes=$TotalBytes+$Bytes
  # done
  # TotalMeg=$(echo -e "scale=3 \nx=$TotalBytes/1048576\n if (x<1) {print \"0\"} \n print x \nquit" | bc)
	# unset TotalBytes

	# Show current git branch
  branch=$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "$(git branch | grep '^*' |sed s/\*\ //)"; fi)

  #   Count visible files:
  # let files=$(\ls -l | grep "^-" | wc -l | tr -d " ")
  # let hiddenfiles=$(\ls -l -d .* | grep "^-" | wc -l | tr -d " ")
  # let executables=$(\ls -l | grep ^-..x | wc -l | tr -d " ")
  # let directories=$(\ls -l | grep "^d" | wc -l | tr -d " ")
  # let hiddendirectories=$(\ls -l -d .* | grep "^d" | wc -l | tr -d " ")-2
  # let linktemp=$(\ls -l | grep "^l" | wc -l | tr -d " ")
  # if [ "$linktemp" -eq "0" ]; then
  #     links="0"
  # else
  #     links=" ${linktemp}l"
  # fi
  # unset linktemp
}

PROMPT_COMMAND=prompt_command

function pprom2 {
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

# PS1="$TITLEBAR\
# $BLUE[$LIGHT_RED\!#|\jbg$BLUE]\
# $BLUE[$GREEN\u@\H$BLUE]\
# $BLUE[\
# $WHITE\${files}f.\
# $LIGHT_BLUE\${hiddenfiles}h.\
# $LIGHT_GREEN\${executables}x.\
# $LIGHT_CYAN\${links}l \
# $LIGHT_GRAY(\${TotalMeg}Mb) \
# $WHITE\${directories}d.\
# $LIGHT_BLUE\${hiddendirectories}h\
# $BLUE]\
# $BLUE[\
# $WHITE\$(ps ax | wc -l | sed -e \"s: ::g\")proc\
# $YELLOW (\${branch})\
# $BLUE]\
# \n\
# $BLUE[$RED\$PWD$BLUE]\
# $WHITE\$\
# \
# $NO_COLOUR "
# PS2='> '
# PS4='+ '

PS1="$TITLEBAR\
$BLUE[$LIGHT_RED\!#|\jbg$BLUE]\
$BLUE[$LIGHT_CYAN\u@\H$BLUE]\
$BLUE[\
$WHITE\$(ps ax | wc -l | sed -e \"s: ::g\")proc\
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

pprom2
