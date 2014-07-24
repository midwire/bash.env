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
if [[ -x `which brew` ]]; then
  if [[ -f `brew --prefix`/etc/bash_completion ]]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi

# RVM completions
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
