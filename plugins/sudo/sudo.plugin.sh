# Press Esc twice to prepend "sudo " to the current command line

if [[ $- == *i* ]]; then
  bind '"\e\e": "\C-asudo \C-e"'
fi
