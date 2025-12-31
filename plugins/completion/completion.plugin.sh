source_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source Linux bash_completion if it exists
if [[ -f /etc/bash_completion ]]; then
  . /etc/bash_completion
fi

# Source plugin completions
for i in $source_dir/files/**/* ; do
  if [[ -r "$i" ]]; then
    . $i
  fi
done
unset i

# Turn on brew completion if it exists
if command -v brew &>/dev/null; then
  brew_prefix="$(brew --prefix)"
  if [[ -f "$brew_prefix/etc/bash_completion" ]]; then
    . "$brew_prefix/etc/bash_completion"
  fi
  unset brew_prefix
fi

# RVM completions
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
