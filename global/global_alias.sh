# Now source global aliases
for i in $dot_env_path/global/alias/*.sh ; do
  if [ -r "$i" ]; then
  	. $i
  fi
done
unset i
