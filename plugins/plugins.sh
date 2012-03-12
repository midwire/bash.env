# Source Plugins
for plugin in $plugins ; do
  custom_path="$dot_env_custom/plugins/$plugin/$plugin.plugin.sh"
  standard_path="$dot_env_path/plugins/$plugin/$plugin.plugin.sh"
  if [ -f $custom_path ]; then
    verbose_info "Sourcing custom plugin: '$plugin'"
    source $custom_path
  elif [ -f $standard_path ]; then
    if [[ "$dot_env_verbose" == "1" ]]; then
      verbose_info "Sourcing standard plugin: '$plugin'"
    fi
    source $standard_path
  fi
done
