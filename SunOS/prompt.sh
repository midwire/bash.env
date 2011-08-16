# Prompt
if [[ -x /usr/ucb/ps ]]; then
	PS="/usr/ucb/ps -el"
else
	PS="`which ps` ax"
fi

BG_BLACK="\[\033[0;40m\]"
BG_RED="\[\033[0;41m\]"
BG_GREEN="\[\033[0;42m\]"
BG_BROWN="\[\033[0;43m\]"
BG_BLUE="\[\033[0;44m\]"
BG_MAGENTA="\[\033[0;45m\]"
BG_CYAN="\[\033[0;46m\]"
BG_LIGHT_GRAY="\[\033[0;47m\]"

BLACK="\[\033[0;30m\]"
DARK_GRAY="\[\033[1;30m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
BROWN="\[\033[0;33m\]"
YELLOW="\[\033[1;33m\]"
BLUE="\[\033[0;34m\]"
LIGHT_BLUE="\[\033[1;34m\]"
MAGENTA="\[\033[0;35m\]"
LIGHT_MAGENTA="\[\033[1;35m\]"
CYAN="\[\033[0;36m\]"
LIGHT_CYAN="\[\033[1;36m\]"
LIGHT_GRAY="\[\033[0;37m\]"
WHITE="\[\033[1;37m\]"
NO_COLOUR="\[\033[0m\]"
case $TERM in
    xterm*)
        TITLEBAR='\[\033]0;\u@\H:\w\007\]'
        ;;
    *)
        TITLEBAR=""
        ;;
esac

PS1="[\u@\H]$ "

PS1="$TITLEBAR\
$BLUE[$LIGHT_RED\!#|\jbg$BLUE]\
$BLUE[$GREEN\u@\H$BLUE]\
$BLUE[\
$WHITE\$($PS | wc -l | sed -e \"s: ::g\")proc\
$BLUE]\
\n\
$BLUE[$RED\$PWD$BLUE]\
$WHITE\$\
\
$NO_COLOUR "
