#!/bin/bash
. "${DOT_ENV_PATH}/global/global_colors.sh"

# Last Modified 08/19/2011 by Midwire

function prompt_command {
	# Show current git branch
  branch=$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "$(git branch | grep '^*' |sed s/\*\ //)"; fi)
	rvm_ruby=$(rvm-prompt &>/dev/null; if [ $? -eq 0 ]; then echo "$(rvm-prompt)"; fi)

  # Optional:

  #   Create TotalMeg variable: sum of visible file sizes in current directory
  # local TotalBytes=0
  # for Bytes in $(\ls -l | grep "^-" | awk '{print $5}'); do
  #   let TotalBytes=$TotalBytes+$Bytes
  # done
  # TotalMeg=$(echo -e "scale=3 \nx=$TotalBytes/1048576\n if (x<1) {print \"0\"} \n print x \nquit" | bc)
	# unset TotalBytes

  #   Count visible files in the CWD:
  # let files=$(\ls -l | grep "^-" | wc -l | tr -d " ")
  # let hiddenfiles=$(\ls -l -d .* | grep "^-" | wc -l | tr -d " ")
  # let executables=$(\ls -l | grep ^-..x | wc -l | tr -d " ")
  # let directories=$(\ls -l | grep "^d" | wc -l | tr -d " ")
  # let hiddendirectories=$(\ls -l -d .* | grep "^d" | wc -l | tr -d " ")-2
  # let linktemp=$(\ls -l | grep "^l" | wc -l | tr -d " ")
	# if [ "$linktemp" -eq "0" ]; then
	# 	links="0"
	# else
	# 	links=" ${linktemp}l"
	# fi
  # unset linktemp
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
$BLUE[$LIGHT_CYAN\u@\H$BLUE]\
$BLUE[\
$WHITE\${rvm_ruby}\
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
