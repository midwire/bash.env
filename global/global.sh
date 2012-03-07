for i in $dot_env_path/global/global_*.sh ; do
  if [ -r "$i" ]; then
    . $i
  fi
done
