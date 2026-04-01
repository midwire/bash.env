# Colorize man pages using LESS_TERMCAP variables

# Blinking text start: red (rarely used but needed for completeness)
export LESS_TERMCAP_mb=$'\e[01;31m'

# Bold text: green
export LESS_TERMCAP_md=$'\e[01;32m'
export LESS_TERMCAP_me=$'\e[0m'

# Underlined text: cyan
export LESS_TERMCAP_us=$'\e[04;36m'
export LESS_TERMCAP_ue=$'\e[0m'

# Standout (status bar / search highlights): yellow on dark background
export LESS_TERMCAP_so=$'\e[01;33;40m'
export LESS_TERMCAP_se=$'\e[0m'
