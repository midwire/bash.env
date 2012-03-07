for i in ${dot_env_path}/extra/bash-completion/*.sh ; do
  if [ -r "$i" ]; then
  	. $i
  fi
done
unset i
