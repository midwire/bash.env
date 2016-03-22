# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html

export MARKPATH=$HOME/.marks

function jump {
  cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}

function mark {
  mkdir -p "$MARKPATH"; ln -is "$(pwd)" "$MARKPATH/$1"
}

function unmark {
  rm -i "$MARKPATH/$1"
}

OS=`uname`
if [[ "$OS" == "Darwin" ]]; then
  # OSX VERSION
  function marks {
    \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
  }
else
  function marks {
      ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
  }
fi

function cleanmarks {
  marks=`\ls -1 "$MARKPATH"`
  for m in $marks; do
    if [ ! -e "$MARKPATH/$m" ]; then
      echo "$MARKPATH/$m does not exist, removing..."
      rm "$MARKPATH/$m"
    fi
  done
}

# Autocompletion
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find "$MARKPATH" -type l -exec basename {} \;)
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

alias j='jump'

complete -F _completemarks jump unmark j
