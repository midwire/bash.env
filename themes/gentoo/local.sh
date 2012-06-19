
local prompt_char=$(ps1_prompt_char)

PS1="\[\033[01;31m\]\h\[\033[01;34m\] \W ${prompt_char}\[\033[00m\] "
