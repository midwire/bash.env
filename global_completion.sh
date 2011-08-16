for i in $HOME/.env/bash-completion/*.sh ; do
  if [ -r "$i" ]; then
  	. $i
  fi
done
unset i
