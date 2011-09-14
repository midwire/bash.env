for i in ${DOT_ENV_PATH}/extra/bash-completion/*.sh ; do
  if [ -r "$i" ]; then
  	. $i
  fi
done
unset i
