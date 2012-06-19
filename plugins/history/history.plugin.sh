export HISTIGNORE="&:ls:[bf]g:exit"
export HISTFILESIZE=1500

# Make multiline commands editable
shopt -s cmdhist
shopt -s lithist

# Turn on history and history expansion
set -o histexpand
set -o history
