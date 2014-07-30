THISDIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

scripts="
`brew --prefix`/opt/chruby/share/chruby/chruby.sh
`brew --prefix`/opt/chruby/share/chruby/auto.sh"

for script in $scripts; do
  [[ -r "$script" ]] && . "$script"
done
