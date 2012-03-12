# Always source these plugins
required_plugins="path"

source_required() {
  verbose_info "Sourcing required plugin: '$1'"
  source "$dot_env_path/plugins/path/$1.plugin.sh"
}

for p in $required_plugins; do
  source_required $p
done
